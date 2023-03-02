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

import goodee.gdj58.online.service.TestService;
import goodee.gdj58.online.vo.Example;
import goodee.gdj58.online.vo.Paper;
import goodee.gdj58.online.vo.Question;
import goodee.gdj58.online.vo.Student;
import goodee.gdj58.online.vo.Test;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class TestController {
	@Autowired TestService testService;
	
	// 1. 학생
		// 전체 성적 확인
	@GetMapping("/student/test/testScore")
	public String testScore() {
		return "student/test/testScore";
	}
	
		// 개별 시험 점수 확인
	@GetMapping("/student/test/testPaper")
	public String testPaper(HttpSession session, Model model, int testNo) {
		Student loginStudent = (Student)session.getAttribute("loginStudent");
		int studentNo = loginStudent.getStudentNo();
		int score = testService.getScoreByTest(studentNo, testNo);	// 문제당 5점 * 20 = 총 100점
		List<Map<String, Object>> testList = testService.getTestOne(testNo);
		List<Example> exList = null;		
		for(Map<String, Object> m : testList) {
			int questionNo = (int)m.get("questionNo");
			// 보기
			exList = testService.getExampleList(questionNo);
			if(exList != null) {	
				// testList 문제에 보기들 추가
				for(int i = 0; i < 4; i++) {	// 보기 4개 고정
					m.put("exIdx"+i, exList.get(i).getExampleIdx());
					m.put("exTitle"+i, exList.get(i).getExampleTitle());
					m.put("exOX"+i, exList.get(i).getExampleOX());
				}
			}
			
			// 학생 답
			m.put("answer", testService.getAnswerOfStudent(questionNo));
		}
		
		model.addAttribute("testList", testList);
		model.addAttribute("exList", exList);
		model.addAttribute("score", score);
		return "student/test/testPaper";
	}
	
		// 시험 목록 testActive 컬럼 추가 후 수정
	@GetMapping("/student/test/testList")
	public String testList(HttpSession session, Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage) {
		// 시험 목록
		Student loginStudent = (Student)session.getAttribute("loginStudent");
		List<Integer> takenTestList = testService.getTakenTestList(loginStudent.getStudentNo());
		List<Test> list = testService.getTestList(currentPage, rowPerPage);
		int startPage = ((currentPage-1)/rowPerPage)*rowPerPage+1;	// 한 페이지당 출력 개수와 페이지 수는 동일하다고 설정
		int endPage = startPage + rowPerPage - 1;	// 1~10페이지 목록일 때 10
		int lastPage = (int)Math.ceil(testService.getTestCount()/(double)rowPerPage);	// 가장 끝쪽
		if(endPage > lastPage){	//마지막 페이지보다 더 큰 숫자의 페이지 존재하지 않도록
			endPage = lastPage;
		}

		model.addAttribute("takenTestList", takenTestList);
		model.addAttribute("list", list);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lastPage", lastPage);
		return "student/test/testList";
	}
	
		// 시험 응시
	@GetMapping("student/test/testOne")
	public String testOneForStudent(Model model, int testNo) {
		List<Map<String, Object>> testList = testService.getTestOne(testNo);
		for(Map<String, Object> m : testList) {
			int questionNo = (int)m.get("questionNo");
			List<Example> exList = testService.getExampleList(questionNo);
			// testList 문제에 보기들 추가
			for(int i = 0; i < 4; i++) {	// 보기 4개 고정
				m.put("exIdx"+i, exList.get(i).getExampleIdx());
				m.put("exTitle"+i, exList.get(i).getExampleTitle());
				m.put("exOX"+i, exList.get(i).getExampleOX());
			}
		}
		model.addAttribute("testList", testList);
		return "student/test/testOne";
	}
	@PostMapping("student/test/testOne")
	public String testOneForStudent(HttpSession session
									, Model model
									, @RequestParam(value="questionNo") int[] questionNo
									, @RequestParam(value="answer") int[] answer) {
		Student loginStudent = (Student)session.getAttribute("loginStudent");
		int studentNo = loginStudent.getStudentNo();
		int row = 0;
		for(int i = 0; i < questionNo.length; i++) {
			Paper paper = new Paper();
			paper.setStudentNo(studentNo);
			paper.setQuestionNo(questionNo[i]);
			paper.setAnswer(answer[i]);
			row += testService.addPaper(paper);
		}
		if(row != 20) {	// 총 20문제
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "student/test/testOne";
		}
		return "redirect:/student/test/testList";
	}
	
	
	// 2. 강사
		// 시험 수정
	@GetMapping("teacher/test/modifyTest")
	public String modifyTest(Model model, int testNo) {
		String testTitle = (String)testService.getTestOne(testNo).get(0).get("testTitle");
		String testActive = (String)testService.getTestOne(testNo).get(0).get("testActive");
		model.addAttribute("testTitle", testTitle);
		model.addAttribute("testActive", testActive);
		model.addAttribute("testNo", testNo);
		return "teacher/test/modifyTest";
	}
	@PostMapping("teacher/test/modifyTest")
	public String modifyTest(Model model, Test test) {
		log.debug("\u001B[31m"+test);
		int row = testService.modifyTest(test);
		if(row == 0) {
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "employee/teacher/modifyTest";
		}
		return "redirect:/teacher/test/testList";
	}
	
		// 문제 삭제
	@GetMapping("teacher/test/removeQuestion")
	public String removeQuestionAndExample(int questionNo) {
		testService.removeQuestionAndExample(questionNo);
		return "redirect:/teacher/test/testList";
	}
		// 문제 수정
	@GetMapping("teacher/test/modifyQuestion")
	public String modifyQuestion(Model model, int questionNo) {
		// 문제 보기
		List<Map<String, Object>> list = testService.getQuestionAndExample(questionNo);
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
		int row = testService.modifyQuestion(question);
		log.debug("\u001B[31m"+"문제 수정 후 row : "+row);
		for(int i = 0; i < 4; i++) {	// 보기 4개
			Example example = new Example();
			example.setExampleNo(exampleNo[i]);
			example.setExampleTitle(exampleTitle[i]);
			example.setExampleOX(exampleOX[i]);
			row += testService.modifyExample(example);
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
		model.addAttribute("questionCount", testService.getQuestionCountByTest(testNo));
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
		
		int questionNo = testService.addQuestion(question);
		log.debug("\u001B[31m"+"★★★★★★★★questionNo★★★★★★★★★"+questionNo+"★★★★★★★★★★★★★★★★★★★★★★★★★★★★");	
		int row = 0;
		for(int i = 0; i < 4; i++) {	// 보기 4개
			Example example = new Example();
			example.setQuestionNo(questionNo);
			example.setExampleIdx(exampleIdx[i]);
			example.setExampleTitle(exampleTitle[i]);
			example.setExampleOX(exampleOX[i]);
			row += testService.addExample(example);
		}
		if(row != 4) {	// 보기 4개가 모두 들어가지 않음
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "teacher/test/addQuestion";
		}
		return "redirect:/teacher/test/testOne?testNo="+question.getTestNo();
	}
	
		// 시험 상세
	@GetMapping("teacher/test/testOne")
	public String testOne(Model model, int testNo) {
		List<Map<String, Object>> testList = testService.getTestOne(testNo);
		List<Example> exList = null;			
		for(Map<String, Object> m : testList) {
			log.debug("\u001B[31m"+"★★★★★★★★testList★★★★★★★★★"+m);
			int questionNo = (int)m.get("questionNo");
			exList = testService.getExampleList(questionNo);
			if(exList != null) {	
				// testList 문제에 보기들 추가
				for(int i = 0; i < 4; i++) {	// 보기 4개 고정
					m.put("exIdx"+i, exList.get(i).getExampleIdx());
					m.put("exTitle"+i, exList.get(i).getExampleTitle());
					m.put("exOX"+i, exList.get(i).getExampleOX());
				}
			}
		}
		String testTitle = (String)testService.getTestOne(testNo).get(0).get("testTitle");
		String testActive = (String)testService.getTestOne(testNo).get(0).get("testActive");
	
		model.addAttribute("testTitle", testTitle);
		model.addAttribute("testActive", testActive);
		model.addAttribute("testNo", testNo);
		model.addAttribute("questionCount", testService.getQuestionCountByTest(testNo));
		model.addAttribute("testList", testList);
		model.addAttribute("exList", exList);
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
	public String addTest(Model model
			, Test test
			, Question question
			, @RequestParam(value="exampleIdx") int[] exampleIdx
			, @RequestParam(value="exampleTitle") String[] exampleTitle
			, @RequestParam(value="exampleOX") String[] exampleOX) {
		int testNo = testService.addTest(test);
		log.debug("\u001B[31m"+testNo+"☆☆☆☆☆☆☆☆☆☆☆☆☆");
		question.setTestNo(testNo);
		question.setQuestionIdx(1);	// 시험 등록할 때 무조건 1번 문제로
		int questionNo = testService.addQuestion(question);
		log.debug("\u001B[31m"+"★★★★★★★★questionNo★★★★★★★★★"+questionNo+"★★★★★★★★★★★★★★★★★★★★★★★★★★★★");	
		int row = 0;
		for(int i = 0; i < 4; i++) {	// 보기 4개
			Example example = new Example();
			example.setQuestionNo(questionNo);
			example.setExampleIdx(exampleIdx[i]);
			example.setExampleTitle(exampleTitle[i]);
			example.setExampleOX(exampleOX[i]);
			row += testService.addExample(example);
		}
		if(row != 4) {	// 보기 4개가 모두 들어가지 않음
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "teacher/test/addTest";
		}
		return "redirect:/teacher/test/testList";
	}
		// 시험 삭제
	@GetMapping("/teacher/test/removeTest")
	public String removeTest(int testNo) {
		testService.removeTest(testNo);
		
		// 문제도 삭제해야 함~! 아마 questionNo 구하는 메서드 따로 만들어야 할 것
		
		return "redirect:/teacher/test/testList";
	}	
		// 시험 목록
	@GetMapping("/teacher/test/testList")
	public String testList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage) {
		List<Test> list = testService.getTestList(currentPage, rowPerPage);
		int startPage = ((currentPage-1)/rowPerPage)*rowPerPage+1;	// 한 페이지당 출력 개수와 페이지 수는 동일하다고 설정
		int endPage = startPage + rowPerPage - 1;	// 1~10페이지 목록일 때 10
		int lastPage = (int)Math.ceil(testService.getTestCount()/(double)rowPerPage);	// 가장 끝쪽
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
}
