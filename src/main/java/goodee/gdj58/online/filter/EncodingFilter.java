package goodee.gdj58.online.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebFilter("/*")
public class EncodingFilter implements Filter {
    @Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    	log.debug("\u001B[31m"+"EncodingFilter");	
    	// \u001B[31m: 문자열에 빨간색 넣기(디버깅 구분하기)
    	request.setCharacterEncoding("UTF-8");
		chain.doFilter(request, response);
	}
}
