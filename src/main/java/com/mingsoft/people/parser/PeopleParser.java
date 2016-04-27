package com.mingsoft.people.parser;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.mingsoft.basic.parser.IGeneralParser;

@Component
@Scope("prototype")
public class PeopleParser extends IGeneralParser {

	@Override
	public String parse(String html,Object... obj) {
		super.htmlContent = html;
		init(obj);
		htmlContent = parseGeneral();
		return htmlContent;
	}


}
