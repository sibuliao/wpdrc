package com.wpdrc.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wpdrc.bo.JsonResult;
import com.wpdrc.pojo.User;
import com.wpdrc.service.UserService;

@Controller
@RequestMapping("/login")
public class LoginController {

	@Autowired
	private UserService userService;

	@RequestMapping("/login")
	@ResponseBody
	public JsonResult login(HttpServletRequest request, User user) throws IOException, NoSuchAlgorithmException {
		if (StringUtils.isBlank(user.getAccount()) || StringUtils.isBlank(user.getPassword())) {
			return JsonResult.buildFailJsonResult();
		}
		Decoder decoder = Base64.getDecoder();
		String account = new String(decoder.decode(user.getAccount()), "UTF-8");
		String password = new String(decoder.decode(user.getPassword()), "UTF-8");
		if (StringUtils.isBlank(account) || StringUtils.isBlank(password)) {
			return JsonResult.buildFailJsonResult();
		}

		if (userService.verification(account, password)) {
			// 设置session
			request.getSession().setAttribute("user", account);
			return JsonResult.buildSuccessJsonResult();
		} else {
			return JsonResult.buildFailJsonResult();
		}
	}

	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response)
			throws IOException, NoSuchAlgorithmException {
		request.getSession().removeAttribute("user");
		response.sendRedirect(request.getContextPath() + "/login.jsp");
	}

	// MessageDigest messageDigest = MessageDigest.getInstance("MD5");
	// byte[] md5Bytes = messageDigest.digest("123456".getBytes("UTF-8"));
	// System.out.println(toHex(md5Bytes));
	//
	// private static String toHex(byte[] bytes) {
	// final char[] HEX_DIGITS = "0123456789ABCDEF".toCharArray();
	// StringBuilder ret = new StringBuilder(bytes.length * 2);
	// for (int i = 0; i < bytes.length; i++) {
	// ret.append(HEX_DIGITS[(bytes[i] >> 4) & 0x0f]);
	// ret.append(HEX_DIGITS[bytes[i] & 0x0f]);
	// }
	// return ret.toString();
	// }
}
