package com.iaas.leak.detection.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;


/**
 * The persistent class for the filter database table.
 * 
 */
@Entity
@NamedQuery(name="Filter.findAll", query="SELECT f FROM Filter f")
public class Filter implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="filter_key")
	private int filterKey;

	@Column(name="filter_id")
	private String filterId;

	@Lob
	private String query;

	//bi-directional many-to-one association to RuleFilter
	@OneToMany(mappedBy="filter", cascade={CascadeType.ALL})
	private List<RuleFilter> ruleFilters;

	public Filter() {
	}

	public int getFilterKey() {
		return this.filterKey;
	}

	public void setFilterKey(int filterKey) {
		this.filterKey = filterKey;
	}

	public String getFilterId() {
		return this.filterId;
	}

	public void setFilterId(String filterId) {
		this.filterId = filterId;
	}

	public String getQuery() {
		return this.query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public List<RuleFilter> getRuleFilters() {
		return this.ruleFilters;
	}

	public void setRuleFilters(List<RuleFilter> ruleFilters) {
		this.ruleFilters = ruleFilters;
	}

	public RuleFilter addRuleFilter(RuleFilter ruleFilter) {
		getRuleFilters().add(ruleFilter);
		ruleFilter.setFilter(this);

		return ruleFilter;
	}

	public RuleFilter removeRuleFilter(RuleFilter ruleFilter) {
		getRuleFilters().remove(ruleFilter);
		ruleFilter.setFilter(null);

		return ruleFilter;
	}

}