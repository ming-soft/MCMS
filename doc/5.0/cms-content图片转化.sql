UPDATE cms_content
SET content_img = concat( '[{"path":"', content_img, '"}]' )
WHERE
	content_img IS NOT NULL
	AND trim( content_img ) != ''