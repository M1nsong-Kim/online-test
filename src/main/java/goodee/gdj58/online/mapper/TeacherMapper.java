package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Teacher;

@Mapper
public interface TeacherMapper {
	Teacher selectTeacher(int teacherNo);
	int updateTeacherPw(Map<String, Object> paramMap);	// 매개변수 하나만 가능
	Teacher login(Teacher teacher);
	int selectTeacherCount(String searchWord);
	int deleteTeacher(int teacherNo);
	int insertTeacher(Teacher teacher);
	List<Teacher> selectTeacherList(Map<String, Object> paramMap);
}
