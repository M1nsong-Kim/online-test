package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Student;

@Mapper
public interface StudentMapper {
	List<Integer> selectTakenTestList(int studentNo);
	int updateStudentPw(Map<String, Object> paramMap);	// 매개변수 하나만 가능
	Student login(Student student);
	int selectStudentCount(String searchWord);
	int deleteStudent(int studentNo);
	int insertStudent(Student student);
	List<Student> selectStudentList(Map<String, Object> paramMap);
}
