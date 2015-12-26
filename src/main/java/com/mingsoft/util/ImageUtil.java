package com.mingsoft.util;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.color.ColorSpace;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.ColorConvertOp;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.MemoryCacheImageInputStream;

import org.apache.log4j.Logger;

import com.mortennobel.imagescaling.ResampleOp;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;


/**
 * 通用批量处理图片类
 * @author 王天培QQ:78750478
 * @version 
 * 版本号：100-000-000<br/>
 * 创建日期：2012-03-15<br/>
 * 历史修订：<br/>
 */
public class ImageUtil {
	
	protected static Logger LOGGER = Logger.getLogger(ImageUtil.class);

	/**
	 * 批处理图片
	 * 
	 * @param directoryPath 批处理文件目录
	 * @param sSize 源尺寸
	 * @param tSize 处理后尺寸
	 */
	public static void batchImageWidthHeight(String directoryPath, int sSize, int tSize) {
		// 设置批处理文件目录
		File dir = new File(directoryPath);
		// 获取目录文件列表
		File[] files = dir.listFiles();

		// 判断是否是空目录
		if (files == null) {
			return;
		} else {
			int count = 0;
			// 遍历文件列表
			for (int i = 0; i < files.length; i++) {
				// 如果是目录，进行递归
				if (files[i].isDirectory()) {
					batchImageWidthHeight(files[i].getAbsolutePath(), sSize, tSize);
				} else {

					BufferedImage srcImage;
					try {
						String filePath = files[i].getPath();
						if (isPic(files[i].getPath())) {
							// 读取图片文件
							srcImage = ImageIO.read(files[i]);
							int[] wh = getImageWidthHeight(srcImage, sSize, tSize);
							// ImageHelper.resizeImage(files[i],
							// files[i].getPath(), wh[0], wh[1],
							// filePath.substring(filePath.indexOf("."),
							// filePath.length()).replace(".", ""));
						}

					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				count++;
			}
		}

	}


	/**
	 * 缩放图像透明背景，捕捉到IOException异常后会抛出。
	 * @param root 文件路径
	 * @param scale 规模
	 * @throws IOException IO流异常
	 */
	public static void ChangeImage(String root, double scale) throws IOException {
		File file = new File(root);
		File[] subFile = file.listFiles();
		for (int i = 0; i < subFile.length; i++) {
			//文件或目录名称
			String name = subFile[i].getName();
			//如果该文件是目录
			if (subFile[i].isDirectory()) {
				ChangeImage(subFile[i].getAbsolutePath() + "\\", scale);
			}
			String[] names = name.split("//.");
			if (StringUtil.isBlank(names[0]))
				break;
			ImageUtil.scaleHyaline(root + subFile[i].getName(), root + subFile[i].getName(), scale, true);
		}
	}

	/**
	 * 图像类型转换 GIF->JPG GIF->PNG PNG->JPG PNG->GIF(X)
	 * 
	 * @param source 源图片路径<br>
	 * @param result 输出图片路径
	 */
	public static void convert(String source, String result) {
		try {
			File f = new File(source);
			f.canRead();
			f.canWrite();
			BufferedImage src = ImageIO.read(f);
			ImageIO.write(src, "JPG", new File(result));
		} catch (Exception e) {
			LOGGER.error(e);
		}
	}

	/**
	 * 创建图片,根据BufferedImage流
	 * 
	 * @param path 图片路径 <br>
	 * @param bi 图片对象流
	 */
	public static void createImage(String path, BufferedImage bi) {
		try {
			ImageIO.write(bi, path.substring(path.lastIndexOf("."), path.length()).replace(".", ""), new File(path));
		} catch (IOException e) {
			LOGGER.error(e);
		}
	}

	/**
	 * 创建图片,根据字节数组
	 * 
	 * @param path 图片路径 <br>
	 * @param bt 图片字节数
	 */
	public static void createImage(String path, byte[] bt) {
		// FileUtil.creaetFileByBytes(bt, path);
	}

	/**
	 * 图像切割
	 * 
	 * @param sourceImagePath 源图像地址<br>
	 * @param descDir 输出图像地址<br>
	 * @param width 目标切片宽度<br>
	 * @param height 目标切片高度<br>
	 */
	public static void cut(String sourceImagePath, String descDir, int width, int height) {
		try {
			Image img;
			ImageFilter cropFilter;
			// 读取源图像
			BufferedImage bi = ImageIO.read(new File(sourceImagePath));
			int srcWidth = bi.getHeight(); // 源图宽度
			int srcHeight = bi.getWidth(); // 源图高度
			if (srcWidth > width && srcHeight > height) {
				Image image = bi.getScaledInstance(srcWidth, srcHeight, Image.SCALE_DEFAULT);
				width = 200; // 切片宽度
				height = 150; // 切片高度
				int cols = 0; // 切片横向数量
				int rows = 0; // 切片纵向数量
				// 计算切片的横向和纵向数量
				if (srcWidth % width == 0) {
					cols = srcWidth / width;
				} else {
					cols = (int) Math.floor(srcWidth / width) + 1;
				}
				if (srcHeight % height == 0) {
					rows = srcHeight / height;
				} else {
					rows = (int) Math.floor(srcHeight / height) + 1;
				}
				// 循环建立切片
				// 改进的想法:是否可用多线程加快切割速度
				for (int i = 0; i < rows; i++) {
					for (int j = 0; j < cols; j++) {
						// 四个参数分别为图像起点坐标和宽高
						// 即: CropImageFilter(int x,int y,int width,int height)
						cropFilter = new CropImageFilter(j * 200, i * 150, width, height);
						img = Toolkit.getDefaultToolkit().createImage(new FilteredImageSource(image.getSource(), cropFilter));
						BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
						Graphics g = tag.getGraphics();
						g.drawImage(img, 0, 0, null); // 绘制缩小后的图
						g.dispose();
						// 输出为文件
						ImageIO.write(tag, "JPEG", new File(descDir + "pre_map_" + i + "_" + j + ".jpg"));
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 图片解密 
	 * @param sourceImagePath 图片路径
	 */
	public static void decodeImage(String sourceImagePath) {
		File file = new File(sourceImagePath);
		if (file.exists()) {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int length = -1;
			InputStream is;
			try {
				is = new FileInputStream(file);
				try {
					while ((length = is.read(buffer)) != -1) {
						baos.write(buffer, 0, length);
					}
					baos.flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
				byte[] data = baos.toByteArray();
				data[0] = (byte)0xff;
				
				OutputStream os = new FileOutputStream(file);
				try {
					os.write(data);
					os.flush();
					os.close();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				try {
					is.close();
					baos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}

	/**
	 * 图片加密
	 * @param sourceImagePath 图片路径
	 */
	public static void encodeImage(String sourceImagePath) {
		File file = new File(sourceImagePath);
		if (file.exists()) {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int length = -1;
			InputStream is;
			try {
				is = new FileInputStream(file);
				try {
					while ((length = is.read(buffer)) != -1) {
						baos.write(buffer, 0, length);
					}
					baos.flush();
				} catch (IOException e) {
					e.printStackTrace();
				}
				byte[] data = baos.toByteArray();
				data[0] = (byte)0x00;
				
				OutputStream os = new FileOutputStream(file);
				try {
					os.write(data);
					os.flush();
					os.close();
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				try {
					is.close();
					baos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} catch (FileNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}

	/**
	 * 根据字节流获取图片类型,jpeg,jpg,png
	 * 
	 * @param imageBytes 图像字节流<br>
	 * @return 返回jpeg,jpg,png类型
	 */
	public static String getImageType(byte[] imageBytes) {
		ByteArrayInputStream bais = null;
		MemoryCacheImageInputStream mcis = null;
		try {
			bais = new ByteArrayInputStream(imageBytes);
			mcis = new MemoryCacheImageInputStream(bais);
			Iterator<ImageReader> itr = ImageIO.getImageReaders(mcis);
			while (itr.hasNext()) {
				ImageReader reader = (ImageReader) itr.next();
				String imageName = reader.getClass().getSimpleName();
				if (imageName != null && ("JPEGImageReader".equalsIgnoreCase(imageName))) {
					return "jpeg";
				} else if (imageName != null && ("JPGImageReader".equalsIgnoreCase(imageName))) {
					return "jpg";
				} else if (imageName != null && ("pngImageReader".equalsIgnoreCase(imageName))) {
					return "png";
				}
			}
		} catch (Exception e) {
			LOGGER.error(e);
		}
		return null;
	}

	/**
	 * 获取新图片宽度和高度 根据sourceWidth与targetWidth的比例，重新生成图片大小
	 * 
	 * @param source
	 *            源图片
	 * @param sourceWidth
	 *            源图片宽度
	 * @param targetWidth
	 *            新图片宽度
	 * @return 返回整型数组，[0]宽度，[1]高度
	 */
	private static int[] getImageWidthHeight(BufferedImage source, int sourceWidth, int targetWidth) {
		double ts = (double) targetWidth / sourceWidth;
		int newWidth = (int) (source.getWidth() * ts);
		int newHeight = (int) (source.getHeight() * ts);
		if (newWidth < 3)
			newWidth = 3;
		if (newHeight < 3)
			newHeight = 3;
		int[] wh = new int[2];
		wh[0] = newWidth;
		wh[1] = newHeight;
		return wh;
	}

	/**
	 * 获取新图片宽度和高度
	 * 
	 * @param sourceImagePath 源图片
	 * @return 返回整型数组，[0]宽度 [1]高度
	 */
	public static int[] getImageWidthHeight(String sourceImagePath) {
		BufferedImage bi;
		try {
			bi = ImageIO.read(new File(sourceImagePath));

			int[] wh = new int[2];
			wh[0] = bi.getWidth();
			wh[1] = bi.getHeight();
			return wh;
		} catch (IOException e) {
			LOGGER.error(e);
		}
		return null;
	}

	/**
	 * 彩色转为黑白
	 * 
	 * @param sourceImagePath 源图片路径<br>
	 * @param savePath 输出图片路径
	 */
	public static void gray(String sourceImagePath, String savePath) {
		try {
			BufferedImage src = ImageIO.read(new File(sourceImagePath));
			ColorSpace cs = ColorSpace.getInstance(ColorSpace.CS_GRAY);
			ColorConvertOp op = new ColorConvertOp(cs, null);
			src = op.filter(src, null);
			ImageIO.write(src, "JPEG", new File(savePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 检查文件是否是图片
	 * 
	 * @param String
	 *            sourceImagePath 文件路劲 <br>
	 * @return 如果是图片，则返回true，否则返回false
	 */
	private static boolean isPic(String sourceImagePath) {
		// 图片后缀
		String picSfix = "jpg|png|gif";
		String[] temp = picSfix.split("\\|");
		if (sourceImagePath.indexOf(".") > 0) {
			String fileSfix = sourceImagePath.substring(sourceImagePath.indexOf("."), sourceImagePath.length()).replace(".", "");
			for (int i = 0; i < temp.length; i++) {
				if (fileSfix.equals(temp[i]))
					return true;
			}
		}
		return false;
	}

	/**
	 * 测试用主方法
	 * @param args 主方法形参
	 * @throws IOException io异常
	 */
	public static void main(String[] args) throws IOException {
		// String root =
		// "C:\\Documents and Settings\\Administrator\\桌面\\images\\";
		// ChangeImage(root, 0.5625);
//		ImageUtil.rotate("f:/b.jpg");
//		File file = new File("F:\\陶研所");
//		File[] subFile = file.listFiles();
//		for (int i = 0; i < subFile.length; i++) {
//			ImageUtil.createImage(subFile[i].getAbsolutePath(), ImageUtil.resize(subFile[i].getAbsolutePath(), 150, 100));
//		}
	}

	/**
	 * 重新设置图片的宽度高度
	 * 
	 * @param sourceImagePath 图像位置<br>
	 * @param width 新的宽度<br>
	 * @param height 新的高度<br>
	 * @return 返回BufferedImage图像流
	 */
	public static BufferedImage resize(String sourceImagePath, int width, int height) {

		BufferedImage inputBufImage;
		try {
			inputBufImage = ImageIO.read(new File(sourceImagePath));
			ResampleOp resampleOp = new ResampleOp(Math.min(width, inputBufImage.getWidth()), Math.min(height, inputBufImage.getHeight()));
			BufferedImage rescaledTomato = resampleOp.filter(inputBufImage, null);
			return rescaledTomato;
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		return null;
	}

	/**
	 * 获取新图片宽度和高度 根据sourceWidth与targetWidth的比例，重新生成图片大小
	 * 
	 * @param sourceImagePath
	 *            源文件
	 * @param savePath
	 *            输出路径
	 * @param width
	 *            源图片宽度
	 * @param height
	 *            新图片宽度
	 * @param sufix
	 *            图片后缀
	 * @return  如果获取成功，则返回true，否则返回false
	 */
	public static boolean resizeImage(File sourceImagePath, String savePath, int width, int height, String sufix) {
		try {
			BufferedImage inputBufImage = ImageIO.read(sourceImagePath);
			ResampleOp resampleOp = new ResampleOp(Math.min(width, inputBufImage.getWidth()), Math.min(height, inputBufImage.getHeight()));
			BufferedImage rescaledTomato = resampleOp.filter(inputBufImage, null);
			ImageIO.write(rescaledTomato, sufix, new File(savePath));
			return true;
		} catch (Exception e) {
			LOGGER.error(e);
			return false;
		}

	}

	/**
	 * 重置图片大小，输出字节流
	 * 
	 * @param sourceImagePath 源图片路径<br>
	 * @param targetW 新图片宽度<br>
	 * @param targetH 新图片高度<br>
	 * @param type 图片类型jpg,png,bmp,gif
	 * @return 返回byte数组图片流
	 */
	public static byte[] resizeImageForBytes(String sourceImagePath, int targetW, int targetH, String type) {
		try {
			BufferedImage image = resize(sourceImagePath, targetW, targetH);
			ByteArrayOutputStream outStream = new ByteArrayOutputStream();

			// JPEGImageEncoder encoder =
			// JPEGCodec.createJPEGEncoder(outStream);
			// encoder.encode(image);
			ImageIO.write(image, type, outStream);
			outStream.flush();
			byte[] result = outStream.toByteArray();
			outStream.close();
			return result;
		} catch (Exception ex) {
			LOGGER.error(ex);
			return null;
		}
	}

	/**
	 * 获取新图片宽度和高度 根据sourceWidth与targetWidth的比例，重新生成图片大小
	 * 
	 * @param sourceImageFile
	 *            源文件
	 * @param savePath
	 *            输出路径
	 * @param width
	 *            源图片宽度
	 * @param height
	 *            新图片宽度
	 * @param sufix
	 *            图片后缀
	 * @return 如果是获取成功，则返回true，否则返回false
	 */
	public static boolean resizeImageForEncode(File sourceImageFile, String savePath, Integer width, Integer height, String sufix) {
		try {
			
			BufferedImage inputBufImage = ImageIO.read(sourceImageFile);
			ResampleOp resampleOp = new ResampleOp(Math.min(width, inputBufImage.getWidth()), Math.min(height, inputBufImage.getHeight()));
			BufferedImage rescaledTomato = resampleOp.filter(inputBufImage, null);
			ImageIO.write(rescaledTomato, sufix, new File(savePath));
			return true;
		} catch (Exception e) {
			LOGGER.error(e);
			return false;
		}

	}

	/***
	 * 图片旋转
	 * 
	 * @param sourceImagePath
	 *            图片文件路径
	 * @param direction
	 *            旋转方向 0:顺时针90度 1逆时针90度
	 * 
	 */
	public static void rotate(String sourceImagePath, int direction) {
		File file = null;
		BufferedImage original = null;
		BufferedImage bufOut = null;
		int width, height;

		file = new File(sourceImagePath);
		try {
			original = ImageIO.read(file);
		} catch (Exception e) {
			return;
		}

		width = original.getWidth();
		height = original.getHeight();
		bufOut = new BufferedImage(width, height, original.getType());
		// AffineTransform atx = AffineTransform.getScaleInstance(scale, scale);
		AffineTransform atx = new AffineTransform();
		switch (direction) {
			case 0:
				atx.rotate(-Math.PI / 2, width / 2, height / 2);
				break;
			case 1:
				atx.rotate(Math.PI / 2, width / 2, height / 2);
				break;
		}
		AffineTransformOp atop = new AffineTransformOp(atx, AffineTransformOp.TYPE_BICUBIC);
		atop.filter(original, bufOut);
		bufOut = bufOut.getSubimage(0, 0, width, height);
		try {
			ImageIO.write(bufOut, "JPG", new File(sourceImagePath));
		} catch (IOException e) {
			LOGGER.debug(e);
		}
	}

	/**
	 * 保存jpg图片
	 * 
	 * @param sourceImagePath 原始图片地址<br>
	 * @param savePath 保存后的图片地址<br>
	 * @param width 新的图片宽度 0:不改变图片宽度<br>
	 * @param hight 新的图片高度 0:不改变图片高度<br>
	 */
	public static void saveImageAsJpg(String sourceImagePath, String savePath, int width, int hight) {
		BufferedImage srcImage = null;
		String imgType = "JPEG";
		if (sourceImagePath.toLowerCase().endsWith(".png")) {
			imgType = "PNG";
		}
		File saveFile = new File(savePath);
		File fromFile = new File(sourceImagePath);
		try {
			srcImage = ImageIO.read(fromFile);
		} catch (IOException e) {
			LOGGER.error(e);
		}
		if (width > 0 || hight > 0) {
			srcImage = resize(sourceImagePath, width, hight);
		}
		try {
			ImageIO.write(srcImage, imgType, saveFile);
		} catch (IOException e) {
			LOGGER.error(e);
		}
	}

	/**
	 * 缩放图像
	 * 
	 * @param sourceImagePath
	 *            源图像文件地址
	 * @param savePath
	 *            缩放后的图像地址
	 * @param scale
	 *            缩放比例
	 * @param flag
	 *            缩放选择:true 放大; false 缩小;
	 */
	public static void scale(String sourceImagePath, String savePath, double scale, boolean flag) {
		try {
			BufferedImage src = ImageIO.read(new File(sourceImagePath)); // 读入文件
			int width = src.getWidth(); // 得到源图宽
			int height = src.getHeight(); // 得到源图长
			if (flag) {
				// 放大
				width = (int) (width * scale);
				height = (int) (height * scale);
			} else {
				// 缩小
				width = (int) (width / scale);
				height = (int) (height / scale);
			}
			Image image = src.getScaledInstance(width, height, Image.SCALE_DEFAULT);
			BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics g = tag.getGraphics();
			g.drawImage(image, 0, 0, null); // 绘制缩小后的图
			g.dispose();
			ImageIO.write(tag, "JPEG", new File(savePath));// 输出到文件流
		} catch (IOException e) {
			LOGGER.equals(e);
		}
	}

	/**
	 * 缩放图像透明背景
	 * 
	 * @param sourceImagePath
	 *            源图像文件地址
	 * @param savePath
	 *            缩放后的图像地址
	 * @param scale
	 *            缩放比例
	 * @param flag
	 *            缩放选择:true 放大; false 缩小;
	 */
	public static void scaleHyaline(String sourceImagePath, String savePath, double scale, boolean flag) {
		if (ImageUtil.isPic(sourceImagePath)) {

			try {
				BufferedImage src = ImageIO.read(new File(sourceImagePath));
				BufferedImage dstImage = null;
				AffineTransform transform = AffineTransform.getScaleInstance(scale, scale);// 返回表示缩放变换的变换
				AffineTransformOp op = new AffineTransformOp(transform, AffineTransformOp.TYPE_BILINEAR);
				dstImage = op.filter(src, null);

				/********** save到本地 *****************/
				try {
					ImageIO.write(dstImage, "png", new File(savePath));
				} catch (IOException e) {
					e.printStackTrace();
				}
				/********** save end *****************/

			} catch (IOException e) {
				LOGGER.equals(e);
			}

		}

	}


/**
 * 图片剪切
 * @param x 剪切的起点x轴
 * @param y 剪切的起点y轴
 * @param width 剪切后的宽度
 * @param height 剪切后的高度
 * @param sourceImagePath  原始图片路径
 * @param savePath 剪切后保存的路径
 */
	public static void cut(int x ,int y,int width,int height,String sourceImagePath,String savePath) {

		FileInputStream is = null;
		ImageInputStream iis = null;

		try {
			// 读取图片文件
			try {
				is = new FileInputStream(sourceImagePath);
			} catch (FileNotFoundException e) {
				LOGGER.error("图片未找到:" + sourceImagePath);
				LOGGER.error(e);
			}
			/*
			 * 
			 * 返回包含所有当前已注册 ImageReader 的 Iterator，这些 ImageReader 声称能够解码指定格式。
			 * 参数：formatName - 包含非正式格式名称 . （例如 "jpeg" 或 "tiff"）等 。
			 */
			Iterator<ImageReader> it = ImageIO.getImageReadersByFormatName("jpg");
			ImageReader reader = it.next();

			// 获取图片流
			try {
				iis = ImageIO.createImageInputStream(is);
			} catch (IOException e) {
				e.printStackTrace();
				LOGGER.error("图片未找到:" + sourceImagePath);
				LOGGER.error(e);
			}

			/*
			 * <p>iis:读取源.true:只向前搜索 </p>.将它标记为 ‘只向前搜索’。
			 * 此设置意味着包含在输入源中的图像将只按顺序读取，可能允许 reader 避免缓存包含与以前已经读取的图像关联的数据的那些输入部分。
			 */
			reader.setInput(iis, true);

			/*
			 * 
			 * <p>描述如何对流进行解码的类<p>.用于指定如何在输入时从 Java Image I/O
			 * 
			 * 框架的上下文中的流转换一幅图像或一组图像。用于特定图像格式的插件
			 * 
			 * 将从其 ImageReader 实现的 getDefaultReadParam 方法中返回
			 * 
			 * ImageReadParam 的实例。
			 */
			ImageReadParam param = reader.getDefaultReadParam();
			BufferedImage bid = null;
			try {
				bid = reader.read(0);
			} catch (IOException e) {
				LOGGER.error("图片未找到:" + sourceImagePath);
				LOGGER.error(e);
			}
			int _h = bid.getHeight();
			int _w = bid.getWidth();

			/*
			 * 图片裁剪区域。Rectangle 指定了坐标空间中的一个区域，通过 Rectangle 对象
			 * 的左上顶点的坐标（x，y）、宽度和高度可以定义这个区域。
			 */
			Rectangle rect = new Rectangle(x, y, width, height);

//			// 如果图片很小，就不进行图片剪切处理
//			if (_h < height && _w < width) {
//				rect = new Rectangle(0, 0, _h, _w);
//			}
//
//			if (_h < height && _w > width) {
//				rect = new Rectangle((_w - width) / 2, 0, width, _h);
//			}
//
//			if (_w < width && _h > height) {
//				rect = new Rectangle(0, (_h - height) / 2, _w, height);
//			}
//
//			if (_w > width && _h > height) {
//				rect = new Rectangle(x, y, width, height);
//				//rect = new Rectangle((_w - width) / 2, (_h - height) / 2, width, height);
//			}

			// 提供一个 BufferedImage，将其用作解码像素数据的目标。
			param.setSourceRegion(rect);

			/*
			 * 使用所提供的 ImageReadParam 读取通过索引 imageIndex 指定的对象，并将 它作为一个完整的
			 * BufferedImage 返回。
			 */
			BufferedImage bi = null;
			try {
				bi = reader.read(0, param);
			} catch (IOException e) {
				LOGGER.error("图片未找到:" + sourceImagePath);
				LOGGER.error(e);
			}

			// 保存新图片
			try {
				ImageIO.write(bi, "jpg", new File(savePath));
			} catch (IOException e) {
				LOGGER.error("输出路径不正确:" + savePath);
				LOGGER.error(e);
			}

		}

		finally {

			if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					LOGGER.error(e);
				}
			if (iis != null)
				try {
					iis.close();
				} catch (IOException e) {
					LOGGER.error(e);
				}

		}

	}

	/**
	 * 图片格式转换
	 * 
	 * @param path 图片路径 <br>
	 * @param fix 要转换成的文件格式,文件名后缀
	 */
	public static void formatImage(String path, String fix) {
		String _path = path;
		try {
			File file = new File(_path);
			InputStream is = new FileInputStream(file);
			BufferedImage image = ImageIO.read(is);
			BufferedImage tag = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.TYPE_INT_RGB);
			tag.getGraphics().drawImage(image, 0, 0, image.getWidth(), image.getHeight(), null); // 绘制缩小后的图
			FileOutputStream newimage = new FileOutputStream(path.substring(0, path.lastIndexOf(".")) + fix); // 输出到文件流
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);
			encoder.encode(tag);
			newimage.close();
		} catch (Exception ex) {
			LOGGER.equals(ex);
		}

	}


	/**
	 * 缩放图片
	 * @param sourceImagePath 被处理的图片文件路径
	 * @param savePath 处理后保存路径
	 * @param targetWidth 放大(缩小)后的宽度
	 * @param targetHeight 放大(缩小)后的高度
	 * @param more 是否多张图片
	 * @param exp 多张图片的规则，例如1.jpg|2.jpg|3.jpg 那么exp=|
	 */
	public static void zoom(String sourceImagePath, String savePath,int targetWidth,int targetHeight,boolean more, String exp) {
		File file = null;
		BufferedImage original = null;
		BufferedImage bufOut = null;
		int width, height;
		if (more) {
			file = new File(sourceImagePath);
			try {
				original = ImageIO.read(file);
			} catch (IOException e) {
				LOGGER.debug(e);
			}
			width = original.getWidth();
			height = original.getHeight();
			if ((targetWidth>= width) && (targetHeight >= height)) {
				targetWidth = width;
				targetHeight = height;
			}
			bufOut = new BufferedImage(width, height, original.getType());
			double xScale = new Integer(targetWidth).doubleValue() / width;
			double yScale = new Integer(targetHeight).doubleValue() / height;
			double scale = java.lang.Math.min(xScale, yScale);
			int newWidth = new Double(original.getWidth() * scale).intValue();
			int newHeight = new Double(original.getHeight() * scale).intValue();
			AffineTransform atx = AffineTransform.getScaleInstance(scale, scale);
			AffineTransformOp atop = new AffineTransformOp(atx, AffineTransformOp.TYPE_BILINEAR);
			atop.filter(original, bufOut);
			bufOut = bufOut.getSubimage(0, 0, newWidth, newHeight);
			try {
				ImageIO.write(bufOut, "JPG", file);
			} catch (IOException e) {
				LOGGER.debug(e);
			}

		} else {

			if (sourceImagePath == null && sourceImagePath.length() > 0)
				return;
			String[] filePath = sourceImagePath.split(exp);
			if (filePath.length > 0) {
				for (int i = 0; i < filePath.length; i++) {

					file = new File(savePath);
					try {
						original = ImageIO.read(file);
					} catch (Exception e) {
						return;
					}

					width = original.getWidth();
					height = original.getHeight();
					if ((targetWidth >= width) && (targetHeight >= height)) {
						targetWidth = width;
						targetHeight = height;
					}
					bufOut = new BufferedImage(width, height, original.getType());
					double xScale = new Integer(targetWidth).doubleValue() / width;
					double yScale = new Integer(targetHeight).doubleValue() / height;
					double scale = java.lang.Math.min(xScale, yScale);
					int newWidth = new Double(original.getWidth() * scale).intValue();
					int newHeight = new Double(original.getHeight() * scale).intValue();
					AffineTransform atx = AffineTransform.getScaleInstance(scale, scale);
					AffineTransformOp atop = new AffineTransformOp(atx, AffineTransformOp.TYPE_BILINEAR);
					atop.filter(original, bufOut);
					bufOut = bufOut.getSubimage(0, 0, newWidth, newHeight);
					try {
						ImageIO.write(bufOut, "JPG", new File(savePath));
					} catch (IOException e) {
						LOGGER.debug(e);
					}
				}
			}
		}
	}
}
