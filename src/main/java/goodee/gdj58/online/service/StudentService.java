package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.StudentMapper;
import goodee.gdj58.online.vo.Student;

@Service
@Transactional
public class StudentService {
	@Autowired StudentMapper studentMapper;
	// 1. 학생 기능
	// 로그인
	public Student login(Student student) {
		return studentMapper.login(student);
	}
	// 비밀번호 변경
	public int modifyStudentPw(int studentNo, String oldPw, String newPw) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("studentNo", studentNo);
		paramMap.put("oldPw", oldPw);
		paramMap.put("newPw", newPw);
		return studentMapper.updateStudentPw(paramMap);
	}
		
	// 2. 직원이 학생 기능
	// 학생 목록 총 개수
	public int getStudentCount(String searchWord) {
		return studentMapper.selectStudentCount(searchWord);
	}
	
	// 삭제
	public int removeStudent(int studentNo) {
		return studentMapper.deleteStudent(studentNo);
	}
	
	// 등록
	public int addStudent(Student student) {
		return studentMapper.insertStudent(student);
	}
	
	// 목록
	public List<Student> getStudentList(int currentPage, int rowPerPage, String searchWord) {
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("searchWord", searchWord);
		return studentMapper.selectStudentList(paramMap);
	}
}
