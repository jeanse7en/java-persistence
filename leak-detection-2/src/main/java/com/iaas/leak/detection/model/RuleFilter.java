package com.iaas.leak.detection.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the rule_filter database table.
 * 
 */
@Entity
@Table(name="rule_filter")
@NamedQuery(name="RuleFilter.findAll", query="SELECT r FROM RuleFilter r")
public class RuleFilter implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="rulefilt_key")
	private int rulefiltKey;

	//bi-directional many-to-one association to Filter
	@ManyToOne(cascade={CascadeType.ALL}, fetch=FetchType.LAZY)
	@JoinColumn(name="filter_key")
	private Filter filter;

	//bi-directional many-to-one association to Rule
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="rule_key")
	private Rule rule;

	public RuleFilter() {
	}

	public int getRulefiltKey() {
		return this.rulefiltKey;
	}

	public void setRulefiltKey(int rulefiltKey) {
		this.rulefiltKey = rulefiltKey;
	}

	public Filter getFilter() {
		return this.filter;
	}

	public void setFilter(Filter filter) {
		this.filter = filter;
	}

	public Rule getRule() {
		return this.rule;
	}

	public void setRule(Rule rule) {
		this.rule = rule;
	}

}