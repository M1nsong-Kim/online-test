package goodee.gdj58.online.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import goodee.gdj58.online.mapper.IdMapper;

@Service
@Transactional
public class IdService {
	@Autowired IdMapper idMapper;
	
	// null이면 사용 가능한 아이디
	public String getIdCheck(String id) {
		String idCheck = "NO";
		if(idMapper.selectIdCheck(id) == null) {
			idCheck = "YES";
		}
		return idCheck;
	}
}
