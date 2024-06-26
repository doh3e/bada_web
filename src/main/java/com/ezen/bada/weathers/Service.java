package com.ezen.bada.weathers;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface Service {

	int weather_beachName(String beachName);

	Bada_default_DTO weather_beach_defaultInfo(String beach_code);

	List<Bada_default_DTO> getbadalist(String area);

	List<Bada_default_DTO> getbadalist2(String area1, String area2);

	Bada_info_DTO getbeachinfo(int beach_code);
	
	Bada_default_DTO get_Beach_list_data(int beach_code);

	String weatherWarning_search(int beach_code, Object object);

	String searchwhere(String area);

	ArrayList<Bada_info_DTO> getcitybeach(String city);
	
	int getPointcode(int beach_code);

	void viewcountUp(int beach_code);

	List<String> gethashtags(int beach_code);

	String endday(int beach_code);

	String startday(int beach_code);


}
