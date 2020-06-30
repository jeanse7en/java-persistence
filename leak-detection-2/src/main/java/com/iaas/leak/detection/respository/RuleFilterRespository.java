package com.iaas.leak.detection.respository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.iaas.leak.detection.model.RuleFilter;


@Repository
public interface RuleFilterRespository extends JpaRepository<RuleFilter, Integer> {
	
}
