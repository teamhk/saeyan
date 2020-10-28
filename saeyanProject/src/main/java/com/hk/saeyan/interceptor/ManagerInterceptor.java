package com.hk.saeyan.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.hk.saeyan.dto.Members;

public class ManagerInterceptor extends HandlerInterceptorAdapter {

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,	Object obj ) throws Exception {

		System.out.println("-------------- ManagerInterCeptor - preHandle");

		// 여기서 로그인 체크
		// session 객체를 가져옴
		HttpSession session = request.getSession();

		// 1) 우선 여기서 request로 들어온 URL을 알아야함.
		String url = request.getRequestURI();
		// 2) 그걸 request에 담아두고... /auth/login으로 넘어감 .. 
		session.setAttribute("url", url);
		System.out.println("---------------- [ " + url + "]");
		// login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
		Members loginMember = (Members) session.getAttribute("loginMember");

		if ( loginMember == null) {
			// 로그인이 안되어 있는 상태임으로 로그인 폼으로 다시 돌려보냄(redirect)
			response.sendRedirect("/auth/login");
			return false; // 더이상 컨트롤러 요청으로 가지 않도록 false로 반환함
		} else if (!(loginMember.getGrade().equals("2"))){
			System.out.println("Grade = " + loginMember.getGrade());
			response.sendRedirect("/");
			return false; // 더이상 컨트롤러 요청으로 가지 않도록 false로 반환함
		 }

		return true;
	}
}
