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
@WebFilter("/employee/*")	// employee로 시작하는 것만 이 필터 실행
public class EmpLoginFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 설정으로 껐다 켤 수 있는 디버깅
		log.debug("\u001B[31m"+"EmpLoginFilter");
		
		HttpServletRequest req = (HttpServletRequest) request;
		
		if(request instanceof HttpServletRequest) {	// HttpServletRequest로 형변환 가능 여부 확인
			HttpSession session = req.getSession();
			if(session.getAttribute("loginEmp") == null) {	// 직원 로그인 x
				// request가 웹 요청이면 response도 웹 요청이다 -> instanceof 검사 필요 x
				((HttpServletResponse)response).sendRedirect(req.getContextPath()+"/loginEmp"); 
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
