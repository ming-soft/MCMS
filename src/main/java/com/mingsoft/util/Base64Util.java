package com.mingsoft.util;

import org.apache.commons.codec.binary.Base64;

/**
 * 
 * 
 * 
 * <p>
 * <b>铭飞科技流量推广软件</b>
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2013 - 2015
 * </p>
 * 
 * <p>
 * Company:景德镇铭飞科技有限公司
 * </p>
 * 
 * @author killfen
 * 
 * @version 100-000-000
 * 
 *          <p>
 *          版权所有
 *          </p>
 * 
 *          <p>
 *          Comments:java base64加密&解密通用方法
 *          </p>
 * 
 *          <p>
 *          Create Date:2013-9-11
 *          </p>
 * 
 *          <p>
 *          Modification history:暂无
 *          </p>
 */
public class Base64Util {

	static private final int BASELENGTH = 255;
	static final private byte[] base64Alphabet = new byte[BASELENGTH];

	static private final int EIGHTBIT = 8;
	static private final boolean fDebug = false;
	static private final int FOURBYTE = 4;
	static private final int LOOKUPLENGTH = 64;
	static final private char[] lookUpBase64Alphabet = new char[LOOKUPLENGTH];
	static private final char PAD = '=';
	static private final int SIGN = -128;
	static private final int SIXBIT = 6;
	static private final int SIXTEENBIT = 16;
	static private final int TWENTYFOURBITGROUP = 24;
	static {

		for (int i = 0; i < BASELENGTH; i++) {
			base64Alphabet[i] = -1;
		}
		for (int i = 'Z'; i >= 'A'; i--) {
			base64Alphabet[i] = (byte) (i - 'A');
		}
		for (int i = 'z'; i >= 'a'; i--) {
			base64Alphabet[i] = (byte) (i - 'a' + 26);
		}

		for (int i = '9'; i >= '0'; i--) {
			base64Alphabet[i] = (byte) (i - '0' + 52);
		}

		base64Alphabet['+'] = 62;
		base64Alphabet['/'] = 63;

		for (int i = 0; i <= 25; i++)
			lookUpBase64Alphabet[i] = (char) ('A' + i);

		for (int i = 26, j = 0; i <= 51; i++, j++)
			lookUpBase64Alphabet[i] = (char) ('a' + j);

		for (int i = 52, j = 0; i <= 61; i++, j++)
			lookUpBase64Alphabet[i] = (char) ('0' + j);
		lookUpBase64Alphabet[62] = (char) '+';
		lookUpBase64Alphabet[63] = (char) '/';

	}

	/**
	 * Decodes Base64 data into octects
	 * 
	 * @param binaryData
	 *            Byte array containing Base64 data
	 * @return Array containind decoded data.
	 */
	public static byte[] decode(String encoded) {

		if (encoded == null)
			return null;

		char[] base64Data = encoded.toCharArray();
		// remove white spaces
		int len = removeWhiteSpace(base64Data);

		if (len % FOURBYTE != 0) {
			return null;// should be divisible by four
		}

		int numberQuadruple = (len / FOURBYTE);

		if (numberQuadruple == 0)
			return new byte[0];

		byte decodedData[] = null;
		byte b1 = 0, b2 = 0, b3 = 0, b4 = 0, marker0 = 0, marker1 = 0;
		char d1 = 0, d2 = 0, d3 = 0, d4 = 0;

		int i = 0;
		int encodedIndex = 0;
		int dataIndex = 0;
		decodedData = new byte[(numberQuadruple) * 3];

		for (; i < numberQuadruple - 1; i++) {

			if (!isData((d1 = base64Data[dataIndex++])) || !isData((d2 = base64Data[dataIndex++])) || !isData((d3 = base64Data[dataIndex++])) || !isData((d4 = base64Data[dataIndex++])))
				return null;// if found "no data" just return null

			b1 = base64Alphabet[d1];
			b2 = base64Alphabet[d2];
			b3 = base64Alphabet[d3];
			b4 = base64Alphabet[d4];

			decodedData[encodedIndex++] = (byte) (b1 << 2 | b2 >> 4);
			decodedData[encodedIndex++] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
			decodedData[encodedIndex++] = (byte) (b3 << 6 | b4);
		}

		if (!isData((d1 = base64Data[dataIndex++])) || !isData((d2 = base64Data[dataIndex++]))) {
			return null;// if found "no data" just return null
		}

		b1 = base64Alphabet[d1];
		b2 = base64Alphabet[d2];

		d3 = base64Data[dataIndex++];
		d4 = base64Data[dataIndex++];
		if (!isData((d3)) || !isData((d4))) {// Check if they are PAD characters
			if (isPad(d3) && isPad(d4)) { // Two PAD e.g. 3c[Pad][Pad]
				if ((b2 & 0xf) != 0)// last 4 bits should be zero
					return null;
				byte[] tmp = new byte[i * 3 + 1];
				System.arraycopy(decodedData, 0, tmp, 0, i * 3);
				tmp[encodedIndex] = (byte) (b1 << 2 | b2 >> 4);
				return tmp;
			} else if (!isPad(d3) && isPad(d4)) { // One PAD e.g. 3cQ[Pad]
				b3 = base64Alphabet[d3];
				if ((b3 & 0x3) != 0)// last 2 bits should be zero
					return null;
				byte[] tmp = new byte[i * 3 + 2];
				System.arraycopy(decodedData, 0, tmp, 0, i * 3);
				tmp[encodedIndex++] = (byte) (b1 << 2 | b2 >> 4);
				tmp[encodedIndex] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
				return tmp;
			} else {
				return null;// an error like "3c[Pad]r", "3cdX", "3cXd", "3cXX"
							// where X is non data
			}
		} else { // No PAD e.g 3cQl
			b3 = base64Alphabet[d3];
			b4 = base64Alphabet[d4];
			decodedData[encodedIndex++] = (byte) (b1 << 2 | b2 >> 4);
			decodedData[encodedIndex++] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
			decodedData[encodedIndex++] = (byte) (b3 << 6 | b4);

		}

		return decodedData;
	}

	/**
	 * Encodes hex octects into Base64
	 * 
	 * @param binaryData
	 *            Array containing binaryData
	 * @return Encoded Base64 array
	 */
	public static String encode(byte[] binaryData) {

		if (binaryData == null)
			return null;

		int lengthDataBits = binaryData.length * EIGHTBIT;
		if (lengthDataBits == 0) {
			return "";
		}

		int fewerThan24bits = lengthDataBits % TWENTYFOURBITGROUP;
		int numberTriplets = lengthDataBits / TWENTYFOURBITGROUP;
		int numberQuartet = fewerThan24bits != 0 ? numberTriplets + 1 : numberTriplets;
		int numberLines = (numberQuartet - 1) / 19 + 1;
		char encodedData[] = null;

		encodedData = new char[numberQuartet * 4 + numberLines];

		byte k = 0, l = 0, b1 = 0, b2 = 0, b3 = 0;

		int encodedIndex = 0;
		int dataIndex = 0;
		int i = 0;
		if (fDebug) {
			System.out.println("number of triplets = " + numberTriplets);
		}

		for (int line = 0; line < numberLines - 1; line++) {
			for (int quartet = 0; quartet < 19; quartet++) {
				b1 = binaryData[dataIndex++];
				b2 = binaryData[dataIndex++];
				b3 = binaryData[dataIndex++];

				if (fDebug) {
					System.out.println("b1= " + b1 + ", b2= " + b2 + ", b3= " + b3);
				}

				l = (byte) (b2 & 0x0f);
				k = (byte) (b1 & 0x03);

				byte val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);

				byte val2 = ((b2 & SIGN) == 0) ? (byte) (b2 >> 4) : (byte) ((b2) >> 4 ^ 0xf0);
				byte val3 = ((b3 & SIGN) == 0) ? (byte) (b3 >> 6) : (byte) ((b3) >> 6 ^ 0xfc);

				if (fDebug) {
					System.out.println("val2 = " + val2);
					System.out.println("k4 = " + (k << 4));
					System.out.println("vak = " + (val2 | (k << 4)));
				}

				encodedData[encodedIndex++] = lookUpBase64Alphabet[val1];
				encodedData[encodedIndex++] = lookUpBase64Alphabet[val2 | (k << 4)];
				encodedData[encodedIndex++] = lookUpBase64Alphabet[(l << 2) | val3];
				encodedData[encodedIndex++] = lookUpBase64Alphabet[b3 & 0x3f];

				i++;
			}
			encodedData[encodedIndex++] = 0xa;
		}

		for (; i < numberTriplets; i++) {
			b1 = binaryData[dataIndex++];
			b2 = binaryData[dataIndex++];
			b3 = binaryData[dataIndex++];

			if (fDebug) {
				System.out.println("b1= " + b1 + ", b2= " + b2 + ", b3= " + b3);
			}

			l = (byte) (b2 & 0x0f);
			k = (byte) (b1 & 0x03);

			byte val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);

			byte val2 = ((b2 & SIGN) == 0) ? (byte) (b2 >> 4) : (byte) ((b2) >> 4 ^ 0xf0);
			byte val3 = ((b3 & SIGN) == 0) ? (byte) (b3 >> 6) : (byte) ((b3) >> 6 ^ 0xfc);

			if (fDebug) {
				System.out.println("val2 = " + val2);
				System.out.println("k4 = " + (k << 4));
				System.out.println("vak = " + (val2 | (k << 4)));
			}

			encodedData[encodedIndex++] = lookUpBase64Alphabet[val1];
			encodedData[encodedIndex++] = lookUpBase64Alphabet[val2 | (k << 4)];
			encodedData[encodedIndex++] = lookUpBase64Alphabet[(l << 2) | val3];
			encodedData[encodedIndex++] = lookUpBase64Alphabet[b3 & 0x3f];
		}

		// form integral number of 6-bit groups
		if (fewerThan24bits == EIGHTBIT) {
			b1 = binaryData[dataIndex];
			k = (byte) (b1 & 0x03);
			if (fDebug) {
				System.out.println("b1=" + b1);
				System.out.println("b1<<2 = " + (b1 >> 2));
			}
			byte val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
			encodedData[encodedIndex++] = lookUpBase64Alphabet[val1];
			encodedData[encodedIndex++] = lookUpBase64Alphabet[k << 4];
			encodedData[encodedIndex++] = PAD;
			encodedData[encodedIndex++] = PAD;
		} else if (fewerThan24bits == SIXTEENBIT) {
			b1 = binaryData[dataIndex];
			b2 = binaryData[dataIndex + 1];
			l = (byte) (b2 & 0x0f);
			k = (byte) (b1 & 0x03);

			byte val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
			byte val2 = ((b2 & SIGN) == 0) ? (byte) (b2 >> 4) : (byte) ((b2) >> 4 ^ 0xf0);

			encodedData[encodedIndex++] = lookUpBase64Alphabet[val1];
			encodedData[encodedIndex++] = lookUpBase64Alphabet[val2 | (k << 4)];
			encodedData[encodedIndex++] = lookUpBase64Alphabet[l << 2];
			encodedData[encodedIndex++] = PAD;
		}

		encodedData[encodedIndex] = 0xa;

		return new String(encodedData);
	}

	/**
	 * 用base64位加密
	 * 
	 * @param bytes
	 *            字符串子节数组
	 * @return 加密后的字符串
	 */
	public static String getBASE64(byte[] bytes) {
		byte[] s = null;
		if (bytes != null) {
			s = Base64.encodeBase64(bytes);
		}
		return new String(s);
	}

	/**
	 * 解密
	 * 
	 * @param str
	 *            需要解密的base64为字符串
	 * @return 解密后的字符串字节数组
	 */
	public static byte[] getFromBASE64(String str) {
		byte[] b = null;
		if (str != null) {
			try {
				b = Base64.encodeBase64(str.getBytes());
				return b;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return b;
	}

	protected static boolean isBase64(char octect) {
		return (isWhiteSpace(octect) || isPad(octect) || isData(octect));
	}

	protected static boolean isData(char octect) {
		return (base64Alphabet[octect] != -1);
	}

	protected static boolean isPad(char octect) {
		return (octect == PAD);
	}

	protected static boolean isWhiteSpace(char octect) {
		return (octect == 0x20 || octect == 0xd || octect == 0xa || octect == 0x9);
	}

	public static void main(String[] args) {
		String str = "asfd";
		System.out.println(Base64Util.getBASE64(str.getBytes()));
	}

	/**
	 * remove WhiteSpace from MIME containing encoded Base64 data.
	 * 
	 * @param data
	 *            the byte array of base64 data (with WS)
	 * @return the new length
	 */
	protected static int removeWhiteSpace(char[] data) {
		if (data == null)
			return 0;

		// count characters that's not whitespace
		int newSize = 0;
		int len = data.length;
		for (int i = 0; i < len; i++) {
			if (!isWhiteSpace(data[i]))
				data[newSize++] = data[i];
		}
		return newSize;
	}

}
