package com.sbs.cyj.at.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigInteger;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.springframework.web.multipart.MultipartFile;

import com.google.common.cache.LoadingCache;
import com.sbs.cyj.at.dto.Article;
import com.sbs.cyj.at.dto.File;

public class Util {
	public static int getAsInt(Object object) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		} else if (object instanceof Long) {
			return (int) object;
		} else if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return -1;
	}

	public static void changeMapKey(Map<String, Object> param, String oldKey, String newKey) {
		Object value = param.get(oldKey);
		param.remove(oldKey);
		param.put(newKey, value);
	}

	public static String getFileExtTypeCodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
		case "gif":
		case "png":
			return "img";
		case "mp4":
		case "avi":
			return "video";
		case "mp3":
			return "audio";
		}

		return "etc";
	}

	public static String getFileExtType2CodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
			return "jpg";
		case "gif":
			return ext;
		case "png":
			return ext;
		case "mp4":
			return ext;
		case "avi":
			return ext;
		case "mp3":
			return ext;
		}

		return "etc";
	}

	public static String getFileExtFromFileName(String fileName) {
		int pos = fileName.lastIndexOf(".");
		String ext = fileName.substring(pos + 1);

		return ext;
	}

	public static byte[] getFileBytes(InputStream fis) {
		byte[] returnValue = null;

		ByteArrayOutputStream baos = null;

		try {
			baos = new ByteArrayOutputStream();

			byte[] buf = new byte[1024];
			int read = 0;

			while ((read = fis.read(buf, 0, buf.length)) != -1) {
				baos.write(buf, 0, read);
			}

			returnValue = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (baos != null) {
				try {
					baos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return returnValue;
	}

	public static byte[] getFileBytesFromMultipartFile(MultipartFile multipartFile) {
		try {
			return getFileBytes(multipartFile.getInputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public static InputStream getBinaryStreamFromBlob(Blob fileBody) {
		try {
			return fileBody.getBinaryStream();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static <T extends Object> T getCacheData(LoadingCache cache, int key) {
		try {
			return (T)cache.get(key);
		} catch (ExecutionException e) {
			return null;
		}
	}

	public static void putExtraVal(Object obj, String key, Object value) {
		Class cls = obj.getClass();

		try {
			Method getExtraMethod = cls.getDeclaredMethod("getExtra");
			Map<String, Object> extra = (Map<String, Object>) getExtraMethod.invoke(obj);

			if (extra == null) {
				extra = new HashMap<>();
				extra.put(key, value);

				Method setExtraMethod = cls.getDeclaredMethod("setExtra", Map.class);
				setExtraMethod.invoke(obj, extra);
			} else {
				extra.put(key, value);
			}
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static Map<String, Object> getNewMapOf(Map<String, Object> oldMap, String... keys) {
		Map<String, Object> newMap = new HashMap<>();

		for (String key : keys) {
			newMap.put(key, oldMap.get(key));
		}

		return newMap;
	}
}
