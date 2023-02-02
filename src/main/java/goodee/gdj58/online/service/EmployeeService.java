package goodee.gdj58.online.service;
// 서비스는 컨트롤러에서 들어온 값, 매퍼에서 나갈 값을 가공한다

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.EmployeeMapper;
import goodee.gdj58.online.vo.Employee;

@Service
@Transactional	// 실패하면 무조건 롤백 - 전처럼 db단에서의 롤백은 아니다 (메서드에만 붙일 수도 있음)
public class EmployeeService {
	// DI = new EmployeeMapper()
	@Autowired	// bean 안에 employeeMapper 타입에 들어갈 수 있는 게 있는지 스캔 후 주입
	private EmployeeMapper employeeMapper;

	public int getEmpCount(String searchWord) {
		return employeeMapper.selectEmpCount(searchWord);
	}
	
	public int updateEmployeePw(int empNo, String oldPw, String newPw) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("empNo", empNo);
		paramMap.put("oldPw", oldPw);
		paramMap.put("newPw", newPw);
		return employeeMapper.updateEmployeePw(paramMap);
	}
	
	public Employee login(Employee emp) {
		return employeeMapper.login(emp);
	}
	
	public int removeEmployee(int empNo) {
		return employeeMapper.deleteEmployee(empNo);
	}
	
	public int addEmployee(Employee employee) {
		return employeeMapper.insertEmployee(employee);
	}
	
	public List<Employee> getEmployeeList(int currentPage, int rowPerPage, String searchWord){
		// 인터페이스는 객체 생성 불가 -> 기존 방식대로 Mapper mapper = new Mapper(); 불가능 -> 위의 @Autowired
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		return employeeMapper.selectEmployeeList(paramMap);
	}
}
