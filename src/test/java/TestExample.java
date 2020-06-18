import com.kjs.orm.mapper.AdminLogMapper;
import com.kjs.orm.model.AdminLog;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by zhenghui on 2017/4/27.
 */
public class TestExample extends Tester {
    @Autowired
    private AdminLogMapper logMapper;

    @Test
    public void Test1(){
        AdminLog log = logMapper.findById(23246l);
        System.out.println("log->"+log.getOperDescribe());
    }
}
