package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.TeacherMapper;
import goodee.gdj58.online.vo.Teacher;

@Service
@Transactional
public class TeacherService {
	@Autowired TeacherMapper teacherMapper;
	
	// 1. 선생님 기능
	// 프로필
	public Teacher getTeacher(int teacherNo) {
		return teacherMapper.selectTeacher(teacherNo);
	}
	
	// 로그인
	public Teacher login(Teacher teacher) {
		return teacherMapper.login(teacher);
	}
	// 비밀번호 변경
	public int modifyTeacherPw(int teacherNo, String oldPw, String newPw) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("teacherNo", teacherNo);
		paramMap.put("oldPw", oldPw);
		paramMap.put("newPw", newPw);
		return teacherMapper.updateTeacherPw(paramMap);
	}
	
	// 2. 직원의 선생님 기능
	// 선생님 목록 총 개수
	public int getTeacherCount(String searchWord) {
		return teacherMapper.selectTeacherCount(searchWord);
	}
	//삭제
	public int removeTeacher(int teacherNo) {
		return teacherMapper.deleteTeacher(teacherNo);
	}
	// 등록
	public int addTeacher(Teacher teacher) {
		return teacherMapper.insertTeacher(teacher);
	}
	// 목록
	public List<Teacher> getTeacherList(int currentPage, int rowPerPage, String searchWord){
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		return teacherMapper.selectTeacherList(paramMap);
	}
}
