package goodee.gdj58.online.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import goodee.gdj58.online.service.IdService;
import goodee.gdj58.online.service.TeacherService;
import goodee.gdj58.online.vo.Example;
import goodee.gdj58.online.vo.Question;
import goodee.gdj58.online.vo.Teacher;
import goodee.gdj58.online.vo.Test;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TeacherController {
	@Autowired TeacherService teacherService;
	@Autowired IdService idService;
	
	// 1. 선생님 기능
	// 1) 시험
		// 문제 삭제
	@GetMapping("teacher/test/removeQuestion")
	public String removeQuestionAndExample(int questionNo) {
		teacherService.removeQuestionAndExample(questionNo);
		return "redirect:/teacher/test/testList";
	}
		// 문제 수정
	@GetMapping("teacher/test/modifyQuestion")
	public String modifyQuestion(Model model, int questionNo) {
		// 문제 보기
		List<Map<String, Object>> list = teacherService.getQuestionAndExample(questionNo);
		model.addAttribute("list", list);
		log.debug("\u001B[31m"+list.get(0).get("questionIdx"));
		return "teacher/test/modifyQuestion";
	}
	@PostMapping("teacher/test/modifyQuestion")
	public String modifyQuestion(Model model, Question question
							, @RequestParam(value="exampleNo") int[] exampleNo
							, @RequestParam(value="exampleIdx") int[] exampleIdx
							, @RequestParam(value="exampleTitle") String[] exampleTitle
							, @RequestParam(value="exampleOX") String[] exampleOX) {
		log.debug("\u001B[31m"+"아예 안 넘어감?");
		int row = teacherService.modifyQuestion(question);
		log.debug("\u001B[31m"+"문제 수정 후 row : "+row);
		for(int i = 0; i < 4; i++) {	// 보기 4개
			Example example = new Example();
			example.setExampleNo(exampleNo[i]);
			example.setExampleTitle(exampleTitle[i]);
			example.setExampleOX(exampleOX[i]);
			row += teacherService.modifyExample(example);
		}
		log.debug("\u001B[31m"+"보기 수정 후 row : "+row);
		if(row != 5) {	// 문제+보기 == 5
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "teacher/test/modifyQuestion";
		}
		return "redirect:/teacher/test/testList";
	}
	// 문제 등록
	@GetMapping("teacher/test/addQuestion")
	public String addQuestion(Model model, int testNo) {
		model.addAttribute("testNo", testNo);
		model.addAttribute("questionCount", teacherService.getQuestionCountByTest(testNo));
		return "teacher/test/addQuestion";
	}
	@PostMapping("teacher/test/addQuestion")
	public String addQuestion(Model model, Question question
							, @RequestParam(value="exampleIdx") int[] exampleIdx
							, @RequestParam(value="exampleTitle") String[] exampleTitle
							, @RequestParam(value="exampleOX") String[] exampleOX) {
		for(int i : exampleIdx) {
			log.debug("\u001B[31m"+"★★★★★★★★★★보기번호★★★★★★★★"+i+"★★★★★★★★★★★★★★★★★★★★★★★★★★★★");	
		}
		for(String i : exampleTitle) {
			log.debug("\u001B[31m"+"★★★★★★★★보기★★★★★★★★★★"+i+"★★★★★★★★★★★★★★★★★★★★★★★★★★★★");	
		}
		for(String i : exampleOX) {			
			log.debug("\u001B[31m"+"★★★★★★★★정답/오답★★★★★★★★★"+i+"★★★★★★★★★★★★★★★★★★★★★★★★★★★★");	
		}
		
		int questionNo = teacherService.addQuestion(question);
		log.debug("\u001B[31m"+"★★★★★★★★questionNo★★★★★★★★★"+questionNo+"★★★★★★★★★★★★★★★★★★★★★★★★★★★★");	
		int row = 0;
		for(int i = 0; i < 4; i++) {	// 보기 4개
			Example example = new Example();
			example.setQuestionNo(questionNo);
			example.setExampleIdx(exampleIdx[i]);
			example.setExampleTitle(exampleTitle[i]);
			example.setExampleOX(exampleOX[i]);
			row += teacherService.addExample(example);
		}
		if(row != 4) {	// 보기 4개가 모두 들어가지 않음
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "teacher/test/addQuestion";
		}
		return "redirect:/teacher/test/testList";
	}
	
		// 시험 상세
	@GetMapping("teacher/test/testOne")
	public String testOne(Model model, int testNo) {
		List<Map<String, Object>> testList = teacherService.getTestOne(testNo);
		for(Map<String, Object> m : testList) {
			int questionNo = (int)m.get("questionNo");
			List<Example> exList = teacherService.getExampleList(questionNo);
			// testList 문제에 보기들 추가
			for(int i = 0; i < 4; i++) {	// 보기 4개 고정
				m.put("exIdx"+i, exList.get(i).getExampleIdx());
				m.put("exTitle"+i, exList.get(i).getExampleTitle());
				m.put("exOX"+i, exList.get(i).getExampleOX());
			}
		}
		model.addAttribute("testList", testList);
		// 다른 방법
//		List<Example> exList = teacherService.getExampleList();
//		model.addAttribute("exList", exList);
		return "teacher/test/testOne";
	}
		// 시험 등록
	@GetMapping("teacher/test/addTest")
	public String addTest() {
		return "teacher/test/addTest";
	}
	@PostMapping("teacher/test/addTest")
	public String addTest(Model model, Test test) {
		int row = teacherService.addTest(test);
		if(row == 0) {
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "teacher/test/addTest";
		}
		return "redirect:/teacher/test/testList";
	}
		// 시험 삭제
	@GetMapping("/teacher/test/removeTest")
	public String removeTest(int testNo) {
		teacherService.removeTest(testNo);
		return "redirect:/teacher/test/testList";
	}	
		// 시험 목록
	@GetMapping("/teacher/test/testList")
	public String testList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage) {
		List<Test> list = teacherService.getTestList(currentPage, rowPerPage);
		int startPage = ((currentPage-1)/rowPerPage)*rowPerPage+1;	// 한 페이지당 출력 개수와 페이지 수는 동일하다고 설정
		int endPage = startPage + rowPerPage - 1;	// 1~10페이지 목록일 때 10
		int lastPage = (int)Math.ceil(teacherService.getTestCount()/(double)rowPerPage);	// 가장 끝쪽
		if(endPage > lastPage){	//마지막 페이지보다 더 큰 숫자의 페이지 존재하지 않도록
			endPage = lastPage;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lastPage", lastPage);
		return "teacher/test/testList";
	}
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
