package com.iaas.leak.detection;

import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.iaas.leak.detection.job.ErrorDetectionHandler;
import com.iaas.leak.detection.model.Rule;
import com.iaas.leak.detection.model.RuleFilter;
import com.iaas.leak.detection.respository.RuleFilterRespository;
import com.iaas.leak.detection.respository.RuleRespository;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringBootTest(classes = { Application.class })
@Transactional
public class LeakDetectionTest{
	@Autowired
	private ErrorDetectionHandler errorDetectionHandler;
	@Autowired
	private RuleRespository ruleRespository;
	private RuleFilterRespository ruleFilterRespository;

	@Test
	public void testName() throws Exception {
		errorDetectionHandler.processRules("RULE_1", "FILTER_1");
		List<Rule> rules = ruleRespository.findAll();
		assertEquals(1, rules.size());
		
		Rule rule = rules.get(0);
		assertEquals(1, rule.getRuleFilters().size());
		
		RuleFilter ruleFilter = rule.getRuleFilters().get(0);
		assertNotNull(ruleFilter.getFilter());
		assertNotNull("FILTER_1", ruleFilter.getFilter().getFilterId());
		List<RuleFilter> mapping = ruleFilterRespository.findAll();
		assertEquals(1, mapping.size());
	}
	

	@Test
	public void testName2() throws Exception {
		errorDetectionHandler.processRules("RULE_1", "FILTER_1");
		List<Rule> rules = ruleRespository.findAll();
		assertEquals(1, rules.size());
		
		Rule rule = rules.get(0);
		assertEquals(1, rule.getRuleFilters().size());
		
		RuleFilter ruleFilter = rule.getRuleFilters().get(0);
		assertNotNull(ruleFilter.getFilter());
		assertNotNull("FILTER_1", ruleFilter.getFilter().getFilterId());
		List<RuleFilter> mapping = ruleFilterRespository.findAll();
		assertEquals(1, mapping.size());
	}
}
