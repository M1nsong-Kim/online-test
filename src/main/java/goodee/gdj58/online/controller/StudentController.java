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
import goodee.gdj58.online.service.StudentService;
import goodee.gdj58.online.vo.Student;

@Controller
public class StudentController {
	@Autowired StudentService studentService;
	@Autowired IdService idService;
	
	// 1. 학생 기능
	// 비밀번호 수정
	@GetMapping("/student/modifyStudentPw")
	public String modifyStudentPw() {
		return "student/modifyStudentPw";
	}
	@PostMapping("/student/modifyStudentPw")
	public String modifyStudentPw(HttpSession session, @RequestParam("oldPw") String oldPw, @RequestParam("newPw") String newPw) {
		Student loginStudent = (Student)session.getAttribute("loginStudent");
		studentService.modifyStudentPw(loginStudent.getStudentNo(), oldPw, newPw);
		return "redirect:/loginStudent";
	}
	// 로그인
	@GetMapping("/loginStudent")
	public String loginStudent() {
		return "student/loginStudent";
	}
	@PostMapping("/loginStudent")
	public String loginStudent(HttpSession session, Student student) {
		Student resultStudent = studentService.login(student);
		session.setAttribute("loginStudent", resultStudent);
		return "redirect:/loginStudent";	// sendRedirect, CM -> C
	}
	// 로그아웃
	@GetMapping("/student/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/loginStudent";
	}
	
	// 2. 직원의 학생 기능
	// 삭제
	@GetMapping("/employee/student/removeStudent")
	public String removeStudent(int studentNo) {
		studentService.removeStudent(studentNo);
		return "redirect:/employee/student/studentList";
	}
	
	// 등록
	@GetMapping("/employee/student/addStudent")
	public String addStudent() {
		return "employee/student/addStudent";
	}
	@PostMapping("/employee/student/addStudent")
	public String addStudent(Model model, Student student) {
		String idCheck = idService.getIdCheck(student.getStudentId());
		if(idCheck != null) {
			model.addAttribute("errorMsg", "중복 ID");
			return "employee/student/addStudent";
		}
		int row = studentService.addStudent(student);
		if(row == 0) {
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "student/addStudent";
		}
		return "redirect:/employee/student/studentList";
	}
	
	// 목록
	@GetMapping("/employee/student/studentList")
	public String studentList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage, @RequestParam(value="searchWord", defaultValue="") String searchWord) {
		List<Student> list = studentService.getStudentList(currentPage, rowPerPage, searchWord);
		int startPage = (currentPage-1)*rowPerPage*rowPerPage+1;
		int endPage = startPage+rowPerPage-1;
		int lastPage = (int)Math.ceil(studentService.getStudentCount(searchWord)/(double)rowPerPage);
		if(endPage > lastPage) {
			endPage = lastPage;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lastPage", lastPage);
		return "employee/student/studentList";
	}
}
