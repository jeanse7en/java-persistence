package com.iaas.leak.detection.respository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.iaas.leak.detection.model.Filter;


@Repository
public interface FilterRespository extends JpaRepository<Filter, Integer> {
	/**
	 * get filter by id
	 * @param hasEnded
	 * @return
	 */
	@Query(value = "SELECT * FROM FILTER WHERE filter_id=:filterId", nativeQuery = true)
	public List<Filter> getFilterById(String filterId);
}
