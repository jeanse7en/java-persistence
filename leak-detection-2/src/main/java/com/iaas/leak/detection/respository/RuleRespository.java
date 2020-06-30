package com.iaas.leak.detection.respository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.iaas.leak.detection.model.Rule;


@Repository
public interface RuleRespository extends JpaRepository<Rule, Integer> {
	
	/**
	 * get valid rule
	 * @param hasEnded
	 * @return
	 */
	@Query(value = "SELECT * FROM RULE WHERE has_ended=:hasEnded", nativeQuery = true)
	public List<Rule> findValidRule(@Param("hasEnded") Integer hasEnded);
}
