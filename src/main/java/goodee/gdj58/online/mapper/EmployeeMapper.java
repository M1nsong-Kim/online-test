package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Employee;

@Mapper
public interface EmployeeMapper {
	int selectEmpCount(String searchWord);
	int updateEmployeePw(Map<String, Object> paramMap);	// myBatis는 매개변수 하나만 가능
	Employee login(Employee employee);
	int deleteEmployee(int empNo);
	int insertEmployee(Employee employee);
	// @Select("") 여기에 쿼리 적어도 되지만 이러면 가독성이 떨어져서 수업시간엔 x
	// .xml 파일에 쿼리 적을 거임
	List<Employee> selectEmployeeList(Map<String, Object> paramMap);
}

/*
스프링이 밑의 클래스 등을 다 만들어줌
스프링이 보관하고 있는 이런 객체들을 bean이라고 부름
public class EmployeeMapperClass implements EmployeeMapper{
	
}
*/