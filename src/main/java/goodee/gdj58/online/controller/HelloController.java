package goodee.gdj58.online.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HelloController {
	/*
	@GetMapping("/test")
	public String test() {
		return "test";	// 뷰 이름
	}

	@GetMapping("/test")
	public void test() {
		// 리턴 타입 void -> 메서드 이름이 view 이름이 됨
	}
	 */

	@GetMapping("/test")
	public ModelAndView test() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("test");
		return mv;
	}
	
	// @RequestMapping(value="/test" method=웅앵.GET) 
	// 이런 방법도 있지만 수업 시간엔 GetMapping / PostMapping만 쓸 거임
}