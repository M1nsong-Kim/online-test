package goodee.gdj58.online.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import goodee.gdj58.online.service.EmployeeService;
import goodee.gdj58.online.vo.Employee;

@Controller
public class EmployeeController {
	@Autowired 
	EmployeeService employeeService;
	
	// 로그인
	@GetMapping("/loginEmp")
	public String loginEmp() {
		// 로그인한 상태는 뷰에서 분기
		return "employee/loginEmp";
	}
	@PostMapping("/loginEmp")
	public String loginEmp(HttpSession session, Employee emp) {
		Employee resultEmp = employeeService.login(emp);
		session.setAttribute("loginEmp", resultEmp);
		return "redirect:/employee/empList";	// sendRedirect, CM -> C
	}
	
	// 로그아웃
	@GetMapping("/employee/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/loginEmp";
	}
	
	// 로그인 후에 사용한 기능
	
	// pw 수정
	@GetMapping("/employee/modifyEmpPw")
	public String modifyEmpPw() {
		return "employee/modifyEmpPw";
	}
	@PostMapping("/employee/modifyEmpPw")
	public String modifyEmpPw(HttpSession session, @RequestParam("oldPw") String oldPw, @RequestParam("newPw") String newPw) {
		Employee loginEmp = (Employee)session.getAttribute("loginEmp");
		employeeService.modifyEmployeePw(loginEmp.getEmpNo(), oldPw, newPw);
		return "redirect:/loginEmp";
	}
	
	// 삭제
	@GetMapping("/employee/removeEmp")
	public String removeEmp(@RequestParam("empNo") int empNo) {
		employeeService.removeEmployee(empNo);
		return "redirect:/employee/empList";
	}
	
	// 등록
	@GetMapping("/employee/addEmp")
	public String addEmp() {
		return "employee/addEmp";
	}
	@PostMapping("/employee/addEmp")
	public String addEmp(Model model, Employee employee) {
		int row = employeeService.addEmployee(employee);
		if(row == 0) {
			model.addAttribute("errorMsg", "시스템 에러로 등록 실패");
			return "employee/addEmp";
		}
		return "redirect:/employee/empList";	// sendRedirect, CM -> C
	}
	
	// 목록
	@GetMapping("/employee/empList")
	public String empList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage, @RequestParam(value="rowPerPage", defaultValue="10") int rowPerPage, @RequestParam(value="searchWord", defaultValue="") String searchWord) {
										// Integer.parseInt(), currentPage==null... 얘가 해줌
		List<Employee> list = employeeService.getEmployeeList(currentPage, rowPerPage, searchWord);
		int startPage = ((currentPage-1)/rowPerPage)*rowPerPage+1;	// 한 페이지당 출력 개수와 페이지 수는 동일하다고 설정
		int endPage = startPage + rowPerPage - 1;	// 1~10페이지 목록일 때 10
		int lastPage = (int)Math.ceil(employeeService.getEmpCount(searchWord)/(double)rowPerPage);	// 가장 끝쪽
		if(endPage > lastPage){	//마지막 페이지보다 더 큰 숫자의 페이지 존재하지 않도록
			endPage = lastPage;
		}
		
		// request.setAttribute("list", list);
		model.addAttribute("list", list);	// 위와 동일한 역할을 할 뿐 같은 건 아님
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("lastPage", lastPage);
		return "employee/empList";
	}
}
