/**
The MIT License (MIT) * Copyright (c) 2015 铭飞科技

 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.mingsoft.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Hashtable;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.BinaryBitmap;
import com.google.zxing.DecodeHintType;
import com.google.zxing.LuminanceSource;
import com.google.zxing.MultiFormatReader;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.ReaderException;
import com.google.zxing.Result;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.common.HybridBinarizer;

/**
 * 
 * <p>
 * <b>铭飞基础框架</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2014 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author wangtp
 * 
 * @version 300-001-001
 * 
 *          <p>
 *          版权所有 铭飞科
 *          </p>
 * 
 *          <p>
 *          Comments: 二维码生成与解析通用类
 *          </p>
 * 
 *          <p>
 *          Create Date:2014-1-3
 *          </p>
 * 
 *          <p>
 *          Modification history:
 *          </p>
 */
public class MatrixImageUtil {

	/**
	 * 生成二维码
	 * 
	 * @param content
	 *            需要生成的内容
	 * @param imgPath
	 *            生成后保存的地址
	 * @param width
	 *            宽度
	 * @param height
	 *            高度
	 */
	@SuppressWarnings("deprecation")
    public static void encode(String content, String imgPath, int width, int height) {
		try {
			if (StringUtil.isBlank(content) || StringUtil.isBlank(imgPath)) {
				return;
			}
			BitMatrix byteMatrix;
			byteMatrix = new MultiFormatWriter().encode(new String(content
					.getBytes("utf-8"), "iso-8859-1"), BarcodeFormat.QR_CODE,
					width, height);
			File file = new File(imgPath);
			MatrixToImageWriter.writeToFile(byteMatrix, "png", file);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 解析二维码
	 * 
	 * @param imgPath
	 *            二维码路径
	 * @return 返回解析后的内容
	 */
	@SuppressWarnings("unchecked")
	public static String decode(String imgPath) {
		try {
			File file = new File(imgPath);
			BufferedImage image;
			try {
				image = ImageIO.read(file);
				if (image == null) {
					System.out.println("Could not decode image");
				}
				LuminanceSource source = new BufferedImageLuminanceSource(image);
				BinaryBitmap bitmap = new BinaryBitmap(new HybridBinarizer(
						source));
				Result result;
				@SuppressWarnings("rawtypes")
                Hashtable hints = new Hashtable();
				hints.put(DecodeHintType.CHARACTER_SET, "GBK");
				result = new MultiFormatReader().decode(bitmap, hints);
				String resultStr = result.getText();
				return resultStr;
			} catch (IOException ioe) {
				System.out.println(ioe.toString());
			} catch (ReaderException re) {
				System.out.println(re.toString());
			}

		} catch (Exception ex) {

		}
		return "";
	}
}