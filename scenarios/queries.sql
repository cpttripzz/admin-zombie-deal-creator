-- get link draft version
SELECT `brand_links`.*
FROM `brand_links`
  INNER JOIN `revisioning_revision_infos` ON `revisioning_revision_infos`.`revision_id` = `brand_links`.`id` AND
                                             `revisioning_revision_infos`.`revision_type` = 'BrandLink'
  INNER JOIN `revisioning_revision_infos` `revision_infos_brand_links_join`
    ON `revision_infos_brand_links_join`.`revision_id` = `brand_links`.`id` AND
       `revision_infos_brand_links_join`.`revision_type` = 'BrandLink'
  INNER JOIN `revisioning_revision_sets`
    ON `revisioning_revision_sets`.`id` = `revision_infos_brand_links_join`.`revision_set_id` AND
       `revisioning_revision_sets`.`type` IN ('Revisioning::BrandLinkRevisionSet')
WHERE `revisioning_revision_infos`.`status` = 'PRIMARY_DRAFT' AND `revisioning_revision_sets`.`id` = 4812;

-- revision draft to release
SELECT `revisioning_revision_infos`.*
FROM `revisioning_revision_infos`
WHERE
  `revisioning_revision_infos`.`revision_type` = 'BrandLink' AND `revisioning_revision_infos`.`revision_id` IN (129750);

-- get link draft version
SELECT `revisioning_revision_sets`.*
FROM `revisioning_revision_sets`
WHERE `revisioning_revision_sets`.`id` IN (4812);

-- link with deals in draft
SELECT `brand_links`.*
FROM `brand_links`
WHERE `brand_links`.`id` = 129750
LIMIT 1;
SELECT `deals_composite_commission_deals`.*
FROM `deals_composite_commission_deals`
WHERE `deals_composite_commission_deals`.`brand_link_id` = 129750
LIMIT 1;
SELECT `deals_commission_deals`.*
FROM `deals_commission_deals`
WHERE `deals_commission_deals`.`composite_commission_deal_id` = 152426;
SELECT `deals_commission_deal_rules`.*
FROM `deals_commission_deal_rules`
WHERE `deals_commission_deal_rules`.`commission_deal_id` IN (69128, 69129);
DELETE FROM `deals_commission_deal_rules`
WHERE `deals_commission_deal_rules`.`type` IN ('Deals::ValueRangeRule') AND `deals_commission_deal_rules`.`id` = 76121;
SELECT `revisioning_revision_infos`.*
FROM `revisioning_revision_infos`
WHERE `revisioning_revision_infos`.`revision_id` = 129750 AND `revisioning_revision_infos`.`revision_type` = 'BrandLink'
LIMIT 1;
SELECT `revisioning_revision_sets`.*
FROM `revisioning_revision_sets`
WHERE `revisioning_revision_sets`.`id` = 4812
LIMIT 1;
SELECT COUNT(*)
FROM `brand_link_revision_set_connectors`
WHERE `brand_link_revision_set_connectors`.`brand_link_revision_set_id` = 4812;
SELECT `brand_link_revision_set_connectors`.*
FROM `brand_link_revision_set_connectors`
WHERE `brand_link_revision_set_connectors`.`brand_link_revision_set_id` = 4812;
SELECT `site_list_brands`.*
FROM `site_list_brands`
WHERE `site_list_brands`.`id` IN
      (96652, 98095, 80608, 104410, 104464, 90077, 67042, 304910, 2137880, 2496562, 2496589, 3539351, 3539378, 3540053, 3540080, 4515899, 4515934, 4516804, 4686696, 4697138, 4874522, 4927521, 4933920, 4988074, 5310835)
      AND (`site_list_brands`.deleted_at IS NULL)
ORDER BY site_list_brands.position;
-- delete deals
DELETE FROM `deals_commission_deals`
WHERE `deals_commission_deals`.`type` IN ('Deals::CpaDeal') AND `deals_commission_deals`.`id` = 69128;
DELETE FROM `deals_commission_deal_rules`
WHERE `deals_commission_deal_rules`.`type` IN ('Deals::ValueRangeRule') AND `deals_commission_deal_rules`.`id` = 76122;
DELETE FROM `deals_commission_deals`
WHERE `deals_commission_deals`.`type` IN ('Deals::CplDeal') AND `deals_commission_deals`.`id` = 69129;
SELECT `currencies`.*
FROM `currencies`
WHERE `currencies`.`code` = 'USD'
LIMIT 1;
SELECT `currencies`.*
FROM `currencies`
WHERE `currencies`.`id` = 1
LIMIT 1;
SELECT 1 AS one
FROM `deals_commission_deals`
WHERE (`deals_commission_deals`.`type` = BINARY 'Deals::CpaDeal' AND
       `deals_commission_deals`.`composite_commission_deal_id` = 152426)
LIMIT 1;
-- create new deal
INSERT INTO `deals_commission_deals` (`clicks_source_id`, `comment`, `composite_commission_deal_id`, `created_at`, `currency_id`, `type`, `updated_at`)
VALUES (NULL, NULL, 152426, '2017-07-31 12:39:26', 1, 'Deals::CpaDeal', '2017-07-31 12:39:26');
INSERT INTO `deals_commission_deal_rules` (`commission_deal_id`, `created_at`, `date_range_end`, `date_range_start`, `period_type`, `range_end`, `range_start`, `type`, `updated_at`, `value`)
VALUES (69130, '2017-07-31 12:39:26', NULL, NULL, 'Custom', 9999999999999.99, 0.0, 'Deals::ValueRangeRule',
        '2017-07-31 12:39:26', 45.0);
SELECT `currencies`.*
FROM `currencies`
WHERE `currencies`.`code` = 'USD'
LIMIT 1;
SELECT `currencies`.*
FROM `currencies`
WHERE `currencies`.`id` = 1
LIMIT 1;
SELECT 1 AS one
FROM `deals_commission_deals`
WHERE (`deals_commission_deals`.`type` = BINARY 'Deals::CplDeal' AND
       `deals_commission_deals`.`composite_commission_deal_id` = 152426)
LIMIT 1;
INSERT INTO `deals_commission_deals` (`clicks_source_id`, `comment`, `composite_commission_deal_id`, `created_at`, `currency_id`, `type`, `updated_at`)
VALUES (NULL, NULL, 152426, '2017-07-31 12:39:26', 1, 'Deals::CplDeal', '2017-07-31 12:39:26');
INSERT INTO `deals_commission_deal_rules` (`commission_deal_id`, `created_at`, `date_range_end`, `date_range_start`, `period_type`, `range_end`, `range_start`, `type`, `updated_at`, `value`)
VALUES (69131, '2017-07-31 12:39:26', NULL, NULL, 'Custom', 9999999999999.99, 0.0, 'Deals::ValueRangeRule',
        '2017-07-31 12:39:26', 20.0);
SELECT `revisioning_revision_infos`.*
FROM `revisioning_revision_infos`
WHERE `revisioning_revision_infos`.`revision_id` = 129750 AND `revisioning_revision_infos`.`revision_type` = 'BrandLink'
LIMIT 1;
SELECT `revisioning_revision_sets`.*
FROM `revisioning_revision_sets`
WHERE `revisioning_revision_sets`.`id` = 4812
LIMIT 1;
SELECT `revisioning_revision_sets`.*
FROM `revisioning_revision_sets`
WHERE `revisioning_revision_sets`.`type` IN ('Revisioning::BrandLinkRevisionSet') AND
      `revisioning_revision_sets`.`id` = 4812
LIMIT 1 FOR UPDATE;
SELECT `brand_links`.*
FROM `brand_links`
WHERE `brand_links`.`id` = 129750
LIMIT 1;
SELECT `brand_links`.*
FROM `brand_links`
  INNER JOIN `revisioning_revision_infos` ON `brand_links`.`id` = `revisioning_revision_infos`.`revision_id`
WHERE
  `revisioning_revision_infos`.`revision_set_id` = 4812 AND `revisioning_revision_infos`.`revision_type` = 'BrandLink'
  AND `revisioning_revision_infos`.`status` = 'LATEST_RELEASE'
LIMIT 1;
SELECT `revisioning_revision_infos`.*
FROM `revisioning_revision_infos`
WHERE `revisioning_revision_infos`.`revision_id` = 129749 AND `revisioning_revision_infos`.`revision_type` = 'BrandLink'
LIMIT 1;
SELECT `affiliate_link_urls`.*
FROM `affiliate_link_urls`
WHERE `affiliate_link_urls`.`id` = 2690
LIMIT 1;
SELECT `canonical_urls`.*
FROM `canonical_urls`
WHERE `canonical_urls`.`id` IN (4793);
SELECT `affiliate_link_types`.*
FROM `affiliate_link_types`
WHERE `affiliate_link_types`.`id` = 3
LIMIT 1;
SELECT `brand_links`.*
FROM `brand_links`
WHERE `brand_links`.`id` = 129749
LIMIT 1;
UPDATE `revisioning_revision_infos`
SET `status` = 'EXPIRED', `expired_at` = '2017-07-31 12:39:26', `updated_at` = '2017-07-31 12:39:26'
WHERE `revisioning_revision_infos`.`id` = 141808;
SELECT `brand_links`.*
FROM `brand_links`
WHERE `brand_links`.`id` = 129750
LIMIT 1;
SELECT 1 AS one
FROM `revisioning_revision_infos`
WHERE
  `revisioning_revision_infos`.`status` = 'LATEST_RELEASE' AND `revisioning_revision_infos`.`revision_set_id` = 4812 AND
  `revisioning_revision_infos`.`revision_type` = 'BrandLink' AND (id != 141809)
LIMIT 1;
UPDATE `revisioning_revision_infos`
SET `released_at` = '2017-07-31 12:39:26', `status` = 'LATEST_RELEASE', `updated_at` = '2017-07-31 12:39:26'
WHERE `revisioning_revision_infos`.`id` = 141809;
SELECT `quix_earnings_inputs`.*
FROM `quix_earnings_inputs`
  INNER JOIN `quix_earnings_input_brand_links`
    ON `quix_earnings_inputs`.`id` = `quix_earnings_input_brand_links`.`earnings_input_id`
WHERE `quix_earnings_input_brand_links`.`brand_link_id` = 129750;
SELECT `deals_composite_commission_deals`.*
FROM `deals_composite_commission_deals`
WHERE `deals_composite_commission_deals`.`brand_link_id` = 129750
LIMIT 1;
SELECT `deals_commission_deals`.*
FROM `deals_commission_deals`
WHERE `deals_commission_deals`.`composite_commission_deal_id` = 152426;
SELECT `deals_commission_deal_rules`.*
FROM `deals_commission_deal_rules`
WHERE `deals_commission_deal_rules`.`commission_deal_id` IN (69130, 69131);
SELECT `affiliate_link_urls`.*
FROM `affiliate_link_urls`
WHERE `affiliate_link_urls`.`id` = 2690
LIMIT 1;
SELECT `canonical_urls`.*
FROM `canonical_urls`
WHERE `canonical_urls`.`id` IN (4793);
INSERT INTO `brand_links` (`affiliate_account`, `affiliate_link_type_id`, `affiliate_link_url_id`, `brand_id`, `created_at`, `name`, `notes`, `updated_at`)
VALUES (NULL, 3, 2690, 565, '2017-07-31 12:39:26', NULL, NULL, '2017-07-31 12:39:26');
SELECT `currencies`.*
FROM `currencies`
WHERE `currencies`.`id` = 1
LIMIT 1;
SELECT 1 AS one
FROM `deals_commission_deals`
WHERE (`deals_commission_deals`.`type` = BINARY 'Deals::CpaDeal' AND
       `deals_commission_deals`.`composite_commission_deal_id` IS NULL)
LIMIT 1;
SELECT 1 AS one
FROM `deals_commission_deals`
WHERE (`deals_commission_deals`.`type` = BINARY 'Deals::CplDeal' AND
       `deals_commission_deals`.`composite_commission_deal_id` IS NULL)
LIMIT 1;
INSERT INTO `deals_composite_commission_deals` (`brand_link_id`, `created_at`, `special_rule_id`, `updated_at`)
VALUES (129751, '2017-07-31 12:39:26', NULL, '2017-07-31 12:39:26');
SELECT `deals_composite_commission_deals`.*
FROM `deals_composite_commission_deals`
WHERE `deals_composite_commission_deals`.`id` = 152427
LIMIT 1;
SELECT `brand_links`.*
FROM `brand_links`
WHERE `brand_links`.`id` = 129751
LIMIT 1;
SELECT `revisioning_revision_infos`.*
FROM `revisioning_revision_infos`
WHERE `revisioning_revision_infos`.`revision_id` = 129751 AND `revisioning_revision_infos`.`revision_type` = 'BrandLink'
LIMIT 1;
INSERT INTO `deals_commission_deals` (`clicks_source_id`, `comment`, `composite_commission_deal_id`, `created_at`, `currency_id`, `type`, `updated_at`)
VALUES (NULL, NULL, 152427, '2017-07-31 12:39:26', 1, 'Deals::CpaDeal', '2017-07-31 12:39:26');
INSERT INTO `deals_commission_deal_rules` (`commission_deal_id`, `created_at`, `date_range_end`, `date_range_start`, `period_type`, `range_end`, `range_start`, `type`, `updated_at`, `value`)
VALUES (69132, '2017-07-31 12:39:26', NULL, NULL, 'Custom', 9999999999999.99, 0.0, 'Deals::ValueRangeRule',
        '2017-07-31 12:39:26', 45.0);
SELECT `deals_composite_commission_deals`.*
FROM `deals_composite_commission_deals`
WHERE `deals_composite_commission_deals`.`id` = 152427
LIMIT 1;
SELECT `brand_links`.*
FROM `brand_links`
WHERE `brand_links`.`id` = 129751
LIMIT 1;
SELECT `revisioning_revision_infos`.*
FROM `revisioning_revision_infos`
WHERE `revisioning_revision_infos`.`revision_id` = 129751 AND `revisioning_revision_infos`.`revision_type` = 'BrandLink'
LIMIT 1;
INSERT INTO `deals_commission_deals` (`clicks_source_id`, `comment`, `composite_commission_deal_id`, `created_at`, `currency_id`, `type`, `updated_at`)
VALUES (NULL, NULL, 152427, '2017-07-31 12:39:26', 1, 'Deals::CplDeal', '2017-07-31 12:39:26');
INSERT INTO `deals_commission_deal_rules` (`commission_deal_id`, `created_at`, `date_range_end`, `date_range_start`, `period_type`, `range_end`, `range_start`, `type`, `updated_at`, `value`)
VALUES (69133, '2017-07-31 12:39:26', NULL, NULL, 'Custom', 9999999999999.99, 0.0, 'Deals::ValueRangeRule',
        '2017-07-31 12:39:26', 20.0);
SELECT `revisioning_revision_sets`.*
FROM `revisioning_revision_sets`
WHERE `revisioning_revision_sets`.`id` = 4812
LIMIT 1;
SELECT COUNT(*)
FROM `brand_link_revision_set_connectors`
WHERE `brand_link_revision_set_connectors`.`brand_link_revision_set_id` = 4812;
SELECT `brand_link_revision_set_connectors`.*
FROM `brand_link_revision_set_connectors`
WHERE `brand_link_revision_set_connectors`.`brand_link_revision_set_id` = 4812;
SELECT `site_list_brands`.*
FROM `site_list_brands`
WHERE `site_list_brands`.`id` IN
      (96652, 98095, 80608, 104410, 104464, 90077, 67042, 304910, 2137880, 2496562, 2496589, 3539351, 3539378, 3540053, 3540080, 4515899, 4515934, 4516804, 4686696, 4697138, 4874522, 4927521, 4933920, 4988074, 5310835)
      AND (`site_list_brands`.deleted_at IS NULL)
ORDER BY site_list_brands.position;
SELECT 1 AS one
FROM `revisioning_revision_infos`
WHERE
  `revisioning_revision_infos`.`status` = 'PRIMARY_DRAFT' AND `revisioning_revision_infos`.`revision_set_id` = 4812 AND
  `revisioning_revision_infos`.`revision_type` = 'BrandLink'
LIMIT 1;
-- new revision
INSERT INTO `revisioning_revision_infos` (`created_at`, `deprecated_at`, `expired_at`, `released_at`, `released_by`, `revision_id`, `revision_set_id`, `revision_type`, `status`, `updated_at`)
VALUES
  ('2017-07-31 12:39:26', NULL, NULL, NULL, NULL, 129751, 4812, 'BrandLink', 'PRIMARY_DRAFT', '2017-07-31 12:39:26');
SELECT `brand_links`.*
FROM `brand_links`
  INNER JOIN `revisioning_revision_infos` ON `revisioning_revision_infos`.`revision_id` = `brand_links`.`id` AND
                                             `revisioning_revision_infos`.`revision_type` = 'BrandLink'
  INNER JOIN `revisioning_revision_infos` `revision_infos_brand_links_join`
    ON `revision_infos_brand_links_join`.`revision_id` = `brand_links`.`id` AND
       `revision_infos_brand_links_join`.`revision_type` = 'BrandLink'
  INNER JOIN `revisioning_revision_sets`
    ON `revisioning_revision_sets`.`id` = `revision_infos_brand_links_join`.`revision_set_id` AND
       `revisioning_revision_sets`.`type` IN ('Revisioning::BrandLinkRevisionSet')
WHERE `revisioning_revision_infos`.`status` = 'PRIMARY_DRAFT' AND `revisioning_revision_sets`.`id` = 4812;
SELECT `revisioning_revision_infos`.*
FROM `revisioning_revision_infos`
WHERE
  `revisioning_revision_infos`.`revision_type` = 'BrandLink' AND `revisioning_revision_infos`.`revision_id` IN (129751);
SELECT `revisioning_revision_sets`.*
FROM `revisioning_revision_sets`
WHERE `revisioning_revision_sets`.`id` IN (4812);
SELECT `brand_links`.*
FROM `brand_links`
WHERE `brand_links`.`id` = 129751
LIMIT 1;
SELECT `affiliate_link_urls`.*
FROM `affiliate_link_urls`
WHERE `affiliate_link_urls`.`id` = 2690
LIMIT 1;
SELECT `canonical_urls`.*
FROM `canonical_urls`
WHERE `canonical_urls`.`id` IN (4793);