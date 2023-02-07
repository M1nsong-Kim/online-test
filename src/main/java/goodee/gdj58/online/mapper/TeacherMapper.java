package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Teacher;
import goodee.gdj58.online.vo.Test;

@Mapper
public interface TeacherMapper {
	Test selectTestOne(int testNo);
	int insertTest(Test test);
	int deleteTest(int testNo);
	int selectTestCount();
	List<Test> selectTestList(Map<String, Object> paramMap);
	int updateTeacherPw(Map<String, Object> paramMap);	// 매개변수 하나만 가능
	Teacher login(Teacher teacher);
	int selectTeacherCount(String searchWord);
	int deleteTeacher(int teacherNo);
	int insertTeacher(Teacher teacher);
	List<Teacher> selectTeacherList(Map<String, Object> paramMap);
}
