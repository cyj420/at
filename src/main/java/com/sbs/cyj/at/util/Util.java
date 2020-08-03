package com.sbs.cyj.at.util;

import java.math.BigInteger;

public class Util {
	public static long getAsLong(Object object) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).longValue();
		} else if (object instanceof Long) {
			return (long) object;
		} else if (object instanceof Integer) {
			return (long) object;
		} else if (object instanceof String) {
			return Long.parseLong((String) object);
		}

		return -1;
	}
}
