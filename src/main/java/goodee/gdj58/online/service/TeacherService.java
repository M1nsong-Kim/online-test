package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.TeacherMapper;
import goodee.gdj58.online.vo.Example;
import goodee.gdj58.online.vo.Question;
import goodee.gdj58.online.vo.Teacher;
import goodee.gdj58.online.vo.Test;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class TeacherService {
	@Autowired TeacherMapper teacherMapper;
	
	// 1. 선생님 기능
	// 1) 시험
		// 문제 삭제
	public int removeQuestionAndExample(int questionNo) {
		return teacherMapper.deleteQuestionAndExample(questionNo);
	}
	
		// 보기 수정
	public int modifyExample(Example example) {
		return teacherMapper.updateExample(example);
	}
		// 문제 수정
	public int modifyQuestion(Question question) {
		return teacherMapper.updateQuestion(question);
	}
	
		// 문제 상세
	public List<Map<String, Object>> getQuestionAndExample(int questionNo){
		return teacherMapper.selectQuestionAndExample(questionNo);
	}
	
		// 보기 추가
	public int addExample(Example example) {
		return teacherMapper.insertExample(example);
	}
		// 시험당 문제 개수
	public int getQuestionCountByTest(int testNo) {
		return teacherMapper.selectQuestionCountByTest(testNo);
	}
	
		// 문제 추가
	public int addQuestion(Question question) {
		teacherMapper.insertQuestion(question);
		log.debug("\u001B[31m"+"★★★★★★★★★★★문제번호★★★★★★★★★"+question.getQuestionNo());	
		return question.getQuestionNo();
	}
	
		// 시험 상세
	public List<Map<String, Object>> getTestOne(int testNo) {
		return teacherMapper.selectTestOne(testNo);
	}
	public List<Example> getExampleList(int questionNo){
		return teacherMapper.selectExampleList(questionNo);
	}
		// 시험 등록
	public int addTest(Test test) {
		return teacherMapper.insertTest(test);
	}
		// 시험 삭제
	public int removeTest(int testNo) {
		return teacherMapper.deleteTest(testNo);
	}
		// 시험 목록 총 개수
	public int getTestCount() {
		return teacherMapper.selectTestCount();
	}
		// 시험 목록
	public List<Test> getTestList(int currentPage, int rowPerPage){
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		return teacherMapper.selectTestList(paramMap);
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
