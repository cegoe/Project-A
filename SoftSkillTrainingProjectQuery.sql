SELECT 		booking_id,
			survey_reason_name,
			feedback,
			CASE 
					--question1
					WHEN regexp_extract(feedback, 'What were the main reasons for the rating\(s\) above\?:.*\n', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'What were the main reasons for the rating\(s\) above\?:.*\n', 0), 'What were the main reasons for the rating\(s\) above\?:', '')
					WHEN regexp_extract(feedback, 'What were the main reasons for the rating\(s\) above\?:.*', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'What were the main reasons for the rating\(s\) above\?:.*', 0), 'What were the main reasons for the rating\(s\) above\?:', '')
					--question2
					WHEN regexp_extract(feedback, 'What else could we have done to ease the pain of this experience, if anything\?:.*\n', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'What else could we have done to ease the pain of this experience, if anything\?:.*\n', 0), 'What else could we have done to ease the pain of this experience, if anything\?:', '')
					WHEN regexp_extract(feedback, 'What else could we have done to ease the pain of this experience, if anything\?:.*', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'What else could we have done to ease the pain of this experience, if anything\?:.*', 0), 'What else could we have done to ease the pain of this experience, if anything\?:', '')
					--question3
					WHEN regexp_extract(feedback, 'Who informed you of the alternative solution\?:.*\n', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'Who informed you of the alternative solution\?:.*\n', 0), 'Who informed you of the alternative solution\?:', '')
					WHEN regexp_extract(feedback, 'Who informed you of the alternative solution\?:.*', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'Who informed you of the alternative solution\?:.*', 0), 'Who informed you of the alternative solution\?:', '')
					--question4
					WHEN regexp_extract(feedback, 'What could we have done to earn a score of 10\?:.*\n', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'What could we have done to earn a score of 10\?:.*\n', 0), 'What could we have done to earn a score of 10\?:', '')
					WHEN regexp_extract(feedback, 'What could we have done to earn a score of 10\?:.*', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'What could we have done to earn a score of 10\?:.*', 0), 'What could we have done to earn a score of 10\?:', '')
					--question5
					WHEN regexp_extract(feedback, 'one thing Agoda can do better, what would it be\?:.*\n', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'one thing Agoda can do better, what would it be\?:.*\n', 0), 'one thing Agoda can do better, what would it be\?:', '')
					WHEN regexp_extract(feedback, 'one thing Agoda can do better, what would it be\?:.*', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'one thing Agoda can do better, what would it be\?:.*', 0), 'one thing Agoda can do better, what would it be\?:', '')
					--question6
					WHEN regexp_extract(feedback, 'Do you have any comment on the quality of customer support you received or the agent that helped you\?:.*\n', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'Do you have any comment on the quality of customer support you received or the agent that helped you\?:.*\n', 0), 'Do you have any comment on the quality of customer support you received or the agent that helped you\?:', '')
					WHEN regexp_extract(feedback, 'Do you have any comment on the quality of customer support you received or the agent that helped you\?:.*', 0) != ''
					THEN REPLACE(regexp_extract(feedback, 'Do you have any comment on the quality of customer support you received or the agent that helped you\?:.*', 0), 'Do you have any comment on the quality of customer support you received or the agent that helped you\?:', '')
					ELSE 'empty'
			END AS text_extract,
			team_name,
			fba.guest_nationality_country_code
			location_name,
			affiliate_name,
			star_rating,
			destination_country,
			supplier_code,
			customer_first_contact_type_same_reason,
			no_of_same_reason_ib_ob_customer_tps_before_survey_received,
			customer_last_contact_type_same_reason
from 		ceg.bi_voc_qa_detail biqa
INNER JOIN 	bi_dw.fact_booking_all fba
ON			fba.booking_id = biqa.booking_id
WHERE 		to_date(response_datetime) >= '2019-01-01'
AND 		to_date(response_datetime) <= '2019-06-30'
AND 		csat =5
--AND         team_name = 'EN'

SELECT  	COUNT(*) as num_of_survey,
			team_name
from 		ceg.bi_voc_qa_detail
WHERE 		to_date(response_datetime) >= '2019-01-01'
AND 		to_date(response_datetime) <= '2019-06-30'
GROUP by 	team_name
ORDER by	num_of_survey DESC

SELECT distinct(guest_nationality_country_code) FROM bi_dw.fact_booking_all
--LIMIT 10

