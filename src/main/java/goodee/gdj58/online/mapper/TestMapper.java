package goodee.gdj58.online.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import goodee.gdj58.online.vo.Example;
import goodee.gdj58.online.vo.Paper;
import goodee.gdj58.online.vo.Question;
import goodee.gdj58.online.vo.Test;

@Mapper
public interface TestMapper {
	List<Map<String, Object>> selectScoreList(int studentNo);
	int selectAnswerOfStudent(int questionNo);
	int selectScoreByTest(Map<String, Integer> paramMap);
	int insertPaper(Paper paper);
	List<Integer> selectTakenTestList(int studentNo);
	
	int updateTest(Test test);
	int deleteQuestionAndExample(int questionNo);
	int updateExample(Example example);
	int updateQuestion(Question question);
	List<Map<String,Object>> selectQuestionAndExample(int questionNo);	// 문제+보기 반환
	int insertExample(Example example);
	int selectQuestionCountByTest(int testNo);
	int insertQuestion(Question question);
	List<Example> selectExampleList(int questionNo);
	List<Map<String, Object>> selectTestOne(int testNo);
	int insertTest(Test test);
	int deleteTest(int testNo);
	int selectTestCount();
	List<Test> selectTestList(Map<String, Object> paramMap);
}
