package com.iaas.leak.detection.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the rule database table.
 * 
 */
@Entity
@NamedQuery(name="Rule.findAll", query="SELECT r FROM Rule r")
public class Rule implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="rule_key")
	private int ruleKey;

	@Column(name="rule_id")
	private String ruleId;

	//bi-directional many-to-one association to RuleFilter
	@OneToMany(mappedBy="rule")
	private List<RuleFilter> ruleFilters;

	public Rule() {
	}

	public int getRuleKey() {
		return this.ruleKey;
	}

	public void setRuleKey(int ruleKey) {
		this.ruleKey = ruleKey;
	}

	public String getRuleId() {
		return this.ruleId;
	}

	public void setRuleId(String ruleId) {
		this.ruleId = ruleId;
	}

	public List<RuleFilter> getRuleFilters() {
		return this.ruleFilters;
	}

	public void setRuleFilters(List<RuleFilter> ruleFilters) {
		this.ruleFilters = ruleFilters;
	}

	public RuleFilter addRuleFilter(RuleFilter ruleFilter) {
		getRuleFilters().add(ruleFilter);
		ruleFilter.setRule(this);

		return ruleFilter;
	}

	public RuleFilter removeRuleFilter(RuleFilter ruleFilter) {
		getRuleFilters().remove(ruleFilter);
		ruleFilter.setRule(null);

		return ruleFilter;
	}

}