package com.itender.ms.util;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.image.AreaAveragingScaleFilter;
import java.awt.image.BufferedImage;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageObserver;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import com.itender.ms.convert.ThumbnailConvert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * 图片处理工具类
 * 
 * @author Zoro
 * 
 */
public class ImageUtil {
	private static Logger logger = LoggerFactory.getLogger(ImageUtil.class);

	/**
	 * 如果文件夹不存在，则创建
	 * 
	 * @param path
	 */
	public static void createFolder(String path) {
		try {
			File uploadFilePath = new File(path);
			if (uploadFilePath.exists() == false) {
				uploadFilePath.mkdirs();
			}
		} catch (Exception ex) {
			throw new RuntimeException("创建文件夹异常");
		}
	}

	/**
	 * 根据坐标和宽高裁切图片
	 * 
	 * @param imgPath
	 *            ：图片源
	 * @param imgExt
	 *            ：扩展名
	 * @param x
	 *            ：横坐标
	 * @param y
	 *            ：纵坐标
	 * @param width
	 *            ：宽
	 * @param height
	 *            ：高
	 * @throws IOException
	 */
	public static void cut(String imgPath, String imgExt, int x, int y, int width, int height, String dest) throws IOException {
		FileInputStream is = null;
		ImageInputStream iis = null;
		try {
			is = new FileInputStream(imgPath);
			Iterator<ImageReader> it = ImageIO.getImageReadersByFormatName(imgExt);
			ImageReader reader = it.next();
			iis = ImageIO.createImageInputStream(is);
			reader.setInput(iis, true);
			ImageReadParam param = reader.getDefaultReadParam();
			Rectangle rect = new Rectangle(x, y, width, height);
			param.setSourceRegion(rect);
			BufferedImage bi = reader.read(0, param);
			// 保存新图片
			ImageIO.write(bi, imgExt, new File(dest));
		} finally {
			if (is != null)
				is.close();
			if (iis != null)
				iis.close();
		}
	}

	/**
	 * 根据宽高生成缩略图
	 * 
	 * @param source
	 *            ：图片源
	 * @param imgExt
	 *            ：扩展名
	 * @param width
	 *            ：宽
	 * @param height
	 *            ：高
	 * @param dest
	 *            ：生成后的路径
	 * @param dest
	 *            ：保持原图比例
	 * 
	 */
	public static void zoom(String source, String imgExt, int width, int height, String dest, boolean keepScale) {
		Component canvas = new Canvas();
		try {
			Image image = null;
			try {
				image = ImageIO.read(new File(source));
			} catch (Exception ex) {
				ThumbnailConvert tc = new ThumbnailConvert();
				tc.setCMYK_COMMAND(source);
				image = Toolkit.getDefaultToolkit().getImage(source);
			}
			int sourceWidth = (image.getWidth(new ImageObserver() {
				@Override
				public boolean imageUpdate(Image img, int infoflags, int x, int y, int width, int height) {
					return false;
				}
			}));
			int sourceHeight = image.getHeight(new ImageObserver() {
				@Override
				public boolean imageUpdate(Image img, int infoflags, int x, int y, int width, int height) {
					return false;
				}
			});
			int scaleWidth = width;
			int scaleHeight = height;
			int coordX = 0;
			int coordY = 0;
			if (keepScale) {
				// 实际宽度:目标宽度>实际高度:目标高度
				double widthPercent = (sourceWidth / (double) width);
				double heightPercent = (sourceHeight / (double) height);
				if (widthPercent > heightPercent) {
					scaleHeight = (int) (sourceHeight / widthPercent);
					coordY = (height - scaleHeight) / 2;
				} else {
					scaleWidth = (int) (sourceWidth / heightPercent);
					coordX = (width - scaleWidth) / 2;
				}
			}
			AreaAveragingScaleFilter areaAveragingScaleFilter = new AreaAveragingScaleFilter(scaleWidth, scaleHeight);
			FilteredImageSource filteredImageSource = new FilteredImageSource(image.getSource(), areaAveragingScaleFilter);
			BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
			Graphics graphics = bufferedImage.createGraphics();
			graphics.drawImage(canvas.createImage(filteredImageSource), coordX, coordY, null);
			ImageIO.write(bufferedImage, imgExt, new File(dest));
		} catch (IOException e) {
			throw new RuntimeException("图片缩放异常");
		}
	}

	public static void zoom(InputStream input, String imgExt, int width, int height, OutputStream output, boolean keepScale) {
		Component canvas = new Canvas();
		try {
			Image image = null;
			image = ImageIO.read(input);
			int sourceWidth = (image.getWidth(new ImageObserver() {
				@Override
				public boolean imageUpdate(Image img, int infoflags, int x, int y, int width, int height) {
					return false;
				}
			}));
			int sourceHeight = image.getHeight(new ImageObserver() {
				@Override
				public boolean imageUpdate(Image img, int infoflags, int x, int y, int width, int height) {
					return false;
				}
			});
			int scaleWidth = width;
			int scaleHeight = height;
			int coordX = 0;
			int coordY = 0;
			if (keepScale) {
				// 实际宽度:目标宽度>实际高度:目标高度
				double widthPercent = (sourceWidth / (double) width);
				double heightPercent = (sourceHeight / (double) height);
				if (widthPercent > heightPercent) {
					scaleHeight = (int) (sourceHeight / widthPercent);
					coordY = (height - scaleHeight) / 2;
				} else {
					scaleWidth = (int) (sourceWidth / heightPercent);
					coordX = (width - scaleWidth) / 2;
				}
			}
			AreaAveragingScaleFilter areaAveragingScaleFilter = new AreaAveragingScaleFilter(scaleWidth, scaleHeight);
			FilteredImageSource filteredImageSource = new FilteredImageSource(image.getSource(), areaAveragingScaleFilter);
			BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics graphics = bufferedImage.createGraphics();
			graphics.setColor(Color.WHITE);
			graphics.fillRect(0, 0, width, height);
			graphics.dispose();
			graphics = bufferedImage.createGraphics();
			graphics.drawImage(canvas.createImage(filteredImageSource), coordX, coordY, null);
			graphics.dispose();
			ImageIO.write(bufferedImage, imgExt, output);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);;
			throw new RuntimeException("图片缩放异常");
		}
	}

	public static void zoom(InputStream input, String imgExt, int width, int height, OutputStream output) {
		zoom(input, imgExt, width, height, output, true);
	}

	public static void zoom(String source, String imgExt, int width, int height, String dest) {
		zoom(source, imgExt, width, height, dest, true);
	}

	public static void zoom(String source, int width, int height, String dest) {
		int index = source.lastIndexOf(".");
		zoom(source, source.substring(index + 1), width, height, dest, true);
	}

	/**
	 * 把图片印刷到图片上
	 * 
	 * @param pressImg
	 *            -- 水印文件
	 * @param targetImg
	 *            -- 目标文件
	 * @param x
	 *            --x坐标
	 * @param y
	 *            --y坐标
	 */
	public final static void pressImage(String pressImg, String targetImg, int x, int y) {
		try {
			// 目标文件
			File _file = new File(targetImg);
			Image src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
			Graphics g = image.createGraphics();
			g.drawImage(src, 0, 0, wideth, height, null);

			// 水印文件
			File _filebiao = new File(pressImg);
			Image src_biao = ImageIO.read(_filebiao);
			int wideth_biao = src_biao.getWidth(null);
			int height_biao = src_biao.getHeight(null);
			g.drawImage(src_biao, (wideth - wideth_biao) / 2, (height - height_biao) / 2, wideth_biao, height_biao, null);
			// 水印文件结束
			g.dispose();
			FileOutputStream out = new FileOutputStream(targetImg);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(image);
			out.close();
		} catch (Exception e) {
			throw new RuntimeException("图片水印写入异常");
		}
	}

	/**
	 * 打印文字水印图片
	 * 
	 * @param pressText
	 *            --文字
	 * @param targetImg
	 *            -- 目标图片
	 * @param fontName
	 *            -- 字体名
	 * @param fontStyle
	 *            -- 字体样式
	 * @param color
	 *            -- 字体颜色
	 * @param fontSize
	 *            -- 字体大小
	 * @param x
	 *            -- 偏移量
	 * @param y
	 */

	public static void pressText(String pressText, String targetImg, String fontName, int fontStyle, int color, int fontSize, int x, int y) {
		try {
			File _file = new File(targetImg);
			Image src = ImageIO.read(_file);
			int wideth = src.getWidth(null);
			int height = src.getHeight(null);
			BufferedImage image = new BufferedImage(wideth, height, BufferedImage.TYPE_INT_RGB);
			Graphics g = image.createGraphics();
			g.drawImage(src, 0, 0, wideth, height, null);

			g.setColor(Color.RED);
			g.setFont(new Font(fontName, fontStyle, fontSize));

			g.drawString(pressText, wideth - fontSize - x, height - fontSize / 2 - y);
			g.dispose();
			FileOutputStream out = new FileOutputStream(targetImg);
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(image);
			out.close();
		} catch (Exception e) {
			throw new RuntimeException("图片水印写入异常");
		}
	}
	// 验证码字符集  
    private static final char[] chars = {   
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',   
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',  
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',  
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',   
        'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};  
    // 字符数量  
    private static final int SIZE = 4;  
    // 干扰线数量  
    private static final int LINES = 5;  
    // 宽度  
    private static final int WIDTH = 80;  
    // 高度  
    private static final int HEIGHT = 40;  
    // 字体大小  
    private static final int FONT_SIZE = 30;  
  
    /** 
     * 生成随机验证码及图片 
     * Object[0]：验证码字符串； 
     * Object[1]：验证码图片。 
     */  
    public static Object[] createImage() {  
        StringBuffer sb = new StringBuffer();  
        // 1.创建空白图片  
        BufferedImage image = new BufferedImage(  
            WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);  
        // 2.获取图片画笔  
        Graphics graphic = image.getGraphics();  
        // 3.设置画笔颜色  
        graphic.setColor(Color.PINK);  
        // 4.绘制矩形背景  
        graphic.fillRect(0, 0, WIDTH, HEIGHT);  
        // 5.画随机字符  
        Random ran = new Random();  
        for (int i = 0; i <SIZE; i++) {  
            // 取随机字符索引  
            int n = ran.nextInt(chars.length);  
            // 设置随机颜色  
            graphic.setColor(getRandomColor());  
            // 设置字体大小  
            graphic.setFont(new Font(  
                null, Font.BOLD + Font.ITALIC, FONT_SIZE));  
            // 画字符  
            graphic.drawString(  
                chars[n] + "", i * WIDTH / SIZE, HEIGHT*2/3);  
            // 记录字符  
            sb.append(chars[n]);  
        }  
        // 6.画干扰线  
        for (int i = 0; i < LINES; i++) {  
            // 设置随机颜色  
            graphic.setColor(getRandomColor());  
            // 随机画线  
            graphic.drawLine(ran.nextInt(WIDTH), ran.nextInt(HEIGHT),  
                    ran.nextInt(WIDTH), ran.nextInt(HEIGHT));  
        }  
        // 7.返回验证码和图片  
        return new Object[]{sb.toString(), image};  
    }  
  
    /** 
     * 随机取色 
     */  
    public static Color getRandomColor() {  
        Random ran = new Random();  
        Color color = new Color(ran.nextInt(256),   
                ran.nextInt(256), ran.nextInt(256));  
        return color;  
    }  
      
	
}
