package sukyung.model;

import java.util.List;

public interface InterProductDAO {

	List<ProductVO> showCartList(String userid) throws Exception;

}
