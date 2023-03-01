package goodee.gdj58.online.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import goodee.gdj58.online.service.IdService;
import goodee.gdj58.online.service.TestService;
import goodee.gdj58.online.vo.Student;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class OnlineTestRestController {
	@Autowired TestService testService;
	@Autowired IdService idService;

	// 아이디 중복 확인
	@GetMapping("/idCheck")
	public String idCheckEmp(@RequestParam(value = "empId", required = false) String empId
							, @RequestParam(value = "teacherId", required = false) String teacherId
							, @RequestParam(value = "studentId", required = false) String studentId) {
		if(empId != null) {
			return idService.getIdCheck(empId);			
		}else if(teacherId != null) {
			return idService.getIdCheck(teacherId);
		}else {
			return idService.getIdCheck(studentId);
		}
	}

	// 시험 성적 차트
	@GetMapping("/testScore")
	public Map<String, Integer> testScore(HttpSession session) {
		Student loginStudent = (Student)session.getAttribute("loginStudent");
		int studentNo = loginStudent.getStudentNo();
		List<Map<String, Object>> list = testService.getScoreList(studentNo);
		Map<String, Integer> map = new HashMap<>();
		for(Map<String, Object> m : list) {	
			log.debug("\u001B[31m"+"========map 잘 들어오는지 확인======"+m);
			int testNo = (int)m.get("testNo");
			map.put((String)m.get("testTitle"), testService.getScoreByTest(studentNo, testNo));
		}
		return map;
	}
}
