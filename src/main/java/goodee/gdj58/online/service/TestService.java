package goodee.gdj58.online.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.TestMapper;
import goodee.gdj58.online.vo.Example;
import goodee.gdj58.online.vo.Paper;
import goodee.gdj58.online.vo.Question;
import goodee.gdj58.online.vo.Test;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional
public class TestService {
	@Autowired TestMapper testMapper;
	
	// 1. 학생
	// 답안지 등록
	public int addPaper(Paper paper) {
		return testMapper.insertPaper(paper);
	}
	
	// 이미 응시한 시험 목록
	public List<Integer> getTakenTestList(int studentNo){
		return testMapper.selectTakenTestList(studentNo);
	}
	
	// 2. 강사
	// 시험 수정
	public int modifyTest(Test test) {
		return testMapper.updateTest(test);
	}
	
		// 문제 삭제
	public int removeQuestionAndExample(int questionNo) {
		return testMapper.deleteQuestionAndExample(questionNo);
	}
	
		// 보기 수정
	public int modifyExample(Example example) {
		return testMapper.updateExample(example);
	}
		// 문제 수정
	public int modifyQuestion(Question question) {
		return testMapper.updateQuestion(question);
	}
	
		// 문제 상세
	public List<Map<String, Object>> getQuestionAndExample(int questionNo){
		return testMapper.selectQuestionAndExample(questionNo);
	}
	
		// 보기 추가
	public int addExample(Example example) {
		return testMapper.insertExample(example);
	}
		// 시험당 문제 개수
	public int getQuestionCountByTest(int testNo) {
		return testMapper.selectQuestionCountByTest(testNo);
	}
	
		// 문제 추가
	public int addQuestion(Question question) {
		testMapper.insertQuestion(question);
		log.debug("\u001B[31m"+"★★★★★★★★★★★문제번호★★★★★★★★★"+question.getQuestionNo());	
		return question.getQuestionNo();
	}
	
		// 시험 상세
	public List<Map<String, Object>> getTestOne(int testNo) {
		return testMapper.selectTestOne(testNo);
	}
	public List<Example> getExampleList(int questionNo){
		return testMapper.selectExampleList(questionNo);
	}
		// 시험 등록
	public int addTest(Test test) {
		testMapper.insertTest(test);
		log.debug("\u001B[31m"+"★★★★★★★★★★★시험번호★★★★★★★★★"+test.getTestNo());
		return test.getTestNo();
	}
		// 시험 삭제
	public int removeTest(int testNo) {
		return testMapper.deleteTest(testNo);
	}
		// 시험 목록 총 개수
	public int getTestCount() {
		return testMapper.selectTestCount();
	}
		// 시험 목록
	public List<Test> getTestList(int currentPage, int rowPerPage){
		int beginRow = (currentPage-1)*rowPerPage;
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		return testMapper.selectTestList(paramMap);
	}
}
