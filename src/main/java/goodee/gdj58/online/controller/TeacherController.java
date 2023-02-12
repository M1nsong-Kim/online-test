package goodee.gdj58.online.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import goodee.gdj58.online.service.IdService;
import goodee.gdj58.online.service.TeacherService;
import goodee.gdj58.online.service.TestService;
import goodee.gdj58.online.vo.Teacher;

@Controller
public class TeacherController {
	@Autowired TeacherService teacherService;
	@Autowired TestService testService;
	@Autowired IdService idService;
	
	// 1. 선생님 기능
	// 시험은 Test 따로
	
	// 비밀번호 수정
	@GetMapping("/teacher/modifyTeacherPw")
	public String modifyTeacherPw() {
		return "teacher/modifyTeacherPw";
	}
	@PostMapping("/teacher/modifyTeacherPw")
	public String modifyTeacherPw(HttpSession session, @RequestParam("oldPw") String oldPw, @RequestParam("newPw") String newPw) {
		Teacher loginTeacher = (Teacher)session.getAttribute("loginTeacher");
		teacherService.modifyTeacherPw(loginTeacher.getTeacherNo(), oldPw, newPw);
		return "redirect:/loginTeacher";
	}
	// 로그인
	@GetMapping("/loginTeacher")
	public String loginTeacher() {
		return "teacher/loginTeacher";
	}
	@PostMapping("/loginTeacher")
	public String loginTeacher(HttpSession session, Teacher teacher) {
		Teacher resultTeacher = teacherService.login(teacher);
		session.setAttribute("loginTeacher", resultTeacher);
		return "redirect:/loginTeacher";	// sendRedirect, CM -> C
	}
	// 로그아웃
	@GetMapping("/teacher/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/loginTeacher";
	}

	// 2. 직원의 선생님 기능
	// 삭제
	@GetMapping("/employee/teacher/removeTeacher")
	public String removeTeacher(int teacherNo) {
		teacherService.removeTeacher(teacherNo);
		return "redirect:/employee/teacher/teacherList";
	}	
	// 등록
	@GetMapping("/employee/teacher/addTeacher")
	public String addTeacher() {
		return "employee/teacher/addTeacher";
	}
	@PostMapping("/employee/teacher/addTeacher")
	public String addTeacher(Model model, Teacher teacher) {
		String idCheck = idService.getIdCheck(teacher.getTeacherId());
		if(idCheck != null) {
			model.addAttribute("errorMsg", "중복 ID");
			return "employee/teacher/addTeacher";
		}
		
		int row = teacherService.addTeacher(teacher);
		if(row == 0) {
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "employee/teacher/addTeacher";
		}
		return "redirect:/employee/teacher/teacherList";
	}
	// 목록
	@GetMapping("/employee/teacher/teacherList")
	public String teacherList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage, @RequestParam(value="searchWord", defaultValue="") String searchWord) {
		List<Teacher> list = teacherService.getTeacherList(currentPage, rowPerPage, searchWord);
		int startPage = ((currentPage-1)/rowPerPage)*rowPerPage+1;	// 한 페이지당 출력 개수와 페이지 수는 동일하다고 설정
		int endPage = startPage + rowPerPage - 1;	// 1~10페이지 목록일 때 10
		int lastPage = (int)Math.ceil(teacherService.getTeacherCount(searchWord)/(double)rowPerPage);	// 가장 끝쪽
		if(endPage > lastPage){	//마지막 페이지보다 더 큰 숫자의 페이지 존재하지 않도록
			endPage = lastPage;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lastPage", lastPage);
		return "employee/teacher/teacherList";
	}
}
