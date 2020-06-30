package com.iaas.leak.detection.job;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.iaas.leak.detection.model.Filter;
import com.iaas.leak.detection.model.Rule;
import com.iaas.leak.detection.model.RuleFilter;
import com.iaas.leak.detection.respository.FilterRespository;
import com.iaas.leak.detection.respository.RuleRespository;

/**
 * @author linhdq
 *
 */
@Service
@Transactional
public class ErrorDetectionHandler {

    @Autowired
    private RuleRespository ruleRespository;
    @Autowired
    private FilterRespository filterRespository;
    
	/**
	 * Main flow to process the rules
	 * @return
	 */
	public void processRules(String ruleId, String filterId) {
		Filter filter = writeFilter(filterId);
		writeRule(ruleId, filter);
	}

	private Filter writeFilter(String filterId) {
		Filter filter = new Filter();
		filter.setFilterId(filterId);
		filter.setQuery("IGNORE_HERE");
		return filterRespository.save(filter);
	}

	private Rule writeRule(String ruleId, Filter filter) {
		Rule rule = new Rule();
		rule.setRuleId(ruleId);
		List<RuleFilter> ruleFilters = new ArrayList<RuleFilter>();
		RuleFilter ruleFilter = new RuleFilter();
		ruleFilter.setFilter(filter);
		ruleFilter.setRule(rule);
		ruleFilters.add(ruleFilter);
		rule.setRuleFilters(ruleFilters);
		return ruleRespository.save(rule);
	}
}
