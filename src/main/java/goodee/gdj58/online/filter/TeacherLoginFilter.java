package goodee.gdj58.online.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

@Slf4j	// 로그 객체를 주입( static Log log = new Log(); 같은 것 )
@WebFilter("/teacher/*")
public class TeacherLoginFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 설정으로 껐다 켤 수 있는 디버깅
		log.debug("\u001B[31m"+"TeacherLoginFilter");
		
		HttpServletRequest req = (HttpServletRequest) request;
		
		if(request instanceof HttpServletRequest) {	// HttpServletRequest로 형변환 가능 여부 확인
			HttpSession session = req.getSession();
			if(session.getAttribute("loginTeacher") == null) {	// 강사 로그인 x
				// request가 웹 요청이면 response도 웹 요청이다 -> instanceof 검사 필요 x
				((HttpServletResponse)response).sendRedirect(req.getContextPath()+"/loginTeacher"); 
				return;
			}
		}else {
			log.debug("\u001B[31m"+"웹브라우저 요청만 허용합니다");
			return;
		}
		// controller 전
		chain.doFilter(request, response);
		// controller 후
	}
}
