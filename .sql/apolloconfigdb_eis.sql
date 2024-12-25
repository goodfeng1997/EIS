/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : apolloconfigdb

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 29/05/2024 08:29:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accesskey
-- ----------------------------
DROP TABLE IF EXISTS `accesskey`;
CREATE TABLE `accesskey`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Secret` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'Secret',
  `IsEnabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: enabled, 0: disabled',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_AppId_Secret_DeletedAt`(`AppId` ASC, `Secret` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '访问密钥' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of accesskey
-- ----------------------------

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_AppId_DeletedAt`(`AppId` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_Name`(`Name`(191) ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '应用表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES (1, 'EIS', '企业信息一体化平台', 'EIS', '企业信息一体化平台部', 'apollo', 'apollo@acme.com', b'0', 0, 'default', '2024-05-23 01:05:08', 'apollo', '2024-05-23 10:06:26');

-- ----------------------------
-- Table structure for appnamespace
-- ----------------------------
DROP TABLE IF EXISTS `appnamespace`;
CREATE TABLE `appnamespace`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'app id',
  `Format` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
  `IsPublic` bit(1) NOT NULL DEFAULT b'0' COMMENT 'namespace是否为公共',
  `Comment` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_AppId_Name_DeletedAt`(`AppId` ASC, `Name` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `Name_AppId`(`Name` ASC, `AppId` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '应用namespace定义' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of appnamespace
-- ----------------------------
INSERT INTO `appnamespace` VALUES (1, 'application', 'EIS', 'properties', b'0', 'default app namespace', b'0', 0, 'default', '2024-05-23 01:05:08', '', '2024-05-23 02:00:48');
INSERT INTO `appnamespace` VALUES (2, 'GateWayService', 'EIS', 'properties', b'0', '网关服务', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `appnamespace` VALUES (3, 'AuthService', 'EIS', 'properties', b'0', '鉴权服务', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `appnamespace` VALUES (4, 'AdminService', 'EIS', 'properties', b'0', '管理服务', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `appnamespace` VALUES (5, 'BaseService', 'EIS', 'properties', b'0', '基本服务', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `appnamespace` VALUES (6, 'BackService', 'EIS', 'properties', b'0', '租户服务', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `appnamespace` VALUES (7, 'CodeService', 'EIS', 'properties', b'0', '编码服务', b'0', 0, 'apollo', '2024-05-23 10:16:19', 'apollo', '2024-05-23 10:16:19');
INSERT INTO `appnamespace` VALUES (8, 'TaskService', 'EIS', 'properties', b'0', '定时任务', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `appnamespace` VALUES (9, 'ERPSerivce', 'EIS', 'properties', b'0', '企业管理服务', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `appnamespace` VALUES (10, 'OAService', 'EIS', 'properties', b'0', '办公自动化服务', b'0', 0, 'apollo', '2024-05-23 10:20:06', 'apollo', '2024-05-23 10:20:06');
INSERT INTO `appnamespace` VALUES (11, 'HRService', 'EIS', 'properties', b'0', '人事管理服务', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `appnamespace` VALUES (12, 'PLMService', 'EIS', 'properties', b'0', '项目管理服务', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `appnamespace` VALUES (13, 'KMSService', 'EIS', 'properties', b'0', '知识库服务', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `appnamespace` VALUES (14, 'CRMService', 'EIS', 'properties', b'0', '客户管理服务', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `appnamespace` VALUES (15, 'SCMService', 'EIS', 'properties', b'0', '供应商管理服务', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `appnamespace` VALUES (16, 'ISMSService', 'EIS', 'properties', b'0', '信息安全服务', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `appnamespace` VALUES (17, 'BIService', 'EIS', 'properties', b'0', '报表服务', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `appnamespace` VALUES (18, 'AIService', 'EIS', 'properties', b'0', '智能服务', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');

-- ----------------------------
-- Table structure for audit
-- ----------------------------
DROP TABLE IF EXISTS `audit`;
CREATE TABLE `audit`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `EntityName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '表名',
  `EntityId` int UNSIGNED NULL DEFAULT NULL COMMENT '记录ID',
  `OpName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '操作类型',
  `Comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 224 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日志审计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of audit
-- ----------------------------
INSERT INTO `audit` VALUES (1, 'Item', 1, 'DELETE', NULL, b'0', 0, 'apollo', '2024-05-23 10:06:03', NULL, '2024-05-23 10:06:03');
INSERT INTO `audit` VALUES (2, 'App', 1, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');
INSERT INTO `audit` VALUES (3, 'Namespace', 2, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `audit` VALUES (4, 'AppNamespace', 2, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `audit` VALUES (5, 'Namespace', 3, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `audit` VALUES (6, 'AppNamespace', 3, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `audit` VALUES (7, 'Namespace', 4, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:09:46', NULL, '2024-05-23 10:09:46');
INSERT INTO `audit` VALUES (8, 'AppNamespace', 4, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:09:46', NULL, '2024-05-23 10:09:46');
INSERT INTO `audit` VALUES (9, 'Namespace', 5, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `audit` VALUES (10, 'AppNamespace', 5, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `audit` VALUES (11, 'Namespace', 6, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `audit` VALUES (12, 'AppNamespace', 6, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `audit` VALUES (13, 'Item', 2, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:11:25', NULL, '2024-05-23 10:11:25');
INSERT INTO `audit` VALUES (14, 'Item', 3, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:11:25', NULL, '2024-05-23 10:11:25');
INSERT INTO `audit` VALUES (15, 'Item', 4, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:11:25', NULL, '2024-05-23 10:11:25');
INSERT INTO `audit` VALUES (16, 'Item', 5, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:11:25', NULL, '2024-05-23 10:11:25');
INSERT INTO `audit` VALUES (17, 'Item', 6, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:11:25', NULL, '2024-05-23 10:11:25');
INSERT INTO `audit` VALUES (18, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:11:25', NULL, '2024-05-23 10:11:25');
INSERT INTO `audit` VALUES (19, 'Item', 7, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:12:02', NULL, '2024-05-23 10:12:02');
INSERT INTO `audit` VALUES (20, 'Item', 8, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:12:02', NULL, '2024-05-23 10:12:02');
INSERT INTO `audit` VALUES (21, 'Item', 9, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:12:02', NULL, '2024-05-23 10:12:02');
INSERT INTO `audit` VALUES (22, 'Item', 10, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:12:02', NULL, '2024-05-23 10:12:02');
INSERT INTO `audit` VALUES (23, 'Item', 11, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:12:02', NULL, '2024-05-23 10:12:02');
INSERT INTO `audit` VALUES (24, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:12:02', NULL, '2024-05-23 10:12:02');
INSERT INTO `audit` VALUES (25, 'Namespace', 7, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `audit` VALUES (26, 'AppNamespace', 7, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `audit` VALUES (27, 'Namespace', 8, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `audit` VALUES (28, 'AppNamespace', 8, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `audit` VALUES (29, 'Namespace', 9, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `audit` VALUES (30, 'AppNamespace', 9, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `audit` VALUES (31, 'Namespace', 10, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `audit` VALUES (32, 'AppNamespace', 10, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `audit` VALUES (33, 'Namespace', 11, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `audit` VALUES (34, 'AppNamespace', 11, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `audit` VALUES (35, 'Namespace', 12, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `audit` VALUES (36, 'AppNamespace', 12, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `audit` VALUES (37, 'Namespace', 13, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `audit` VALUES (38, 'AppNamespace', 13, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `audit` VALUES (39, 'Namespace', 14, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `audit` VALUES (40, 'AppNamespace', 14, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `audit` VALUES (41, 'Namespace', 15, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `audit` VALUES (42, 'AppNamespace', 15, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `audit` VALUES (43, 'Namespace', 16, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:25:13', NULL, '2024-05-23 10:25:13');
INSERT INTO `audit` VALUES (44, 'AppNamespace', 16, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:25:13', NULL, '2024-05-23 10:25:13');
INSERT INTO `audit` VALUES (45, 'Namespace', 17, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `audit` VALUES (46, 'AppNamespace', 17, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `audit` VALUES (47, 'Namespace', 18, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');
INSERT INTO `audit` VALUES (48, 'AppNamespace', 18, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');
INSERT INTO `audit` VALUES (49, 'Item', 12, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:27:15', NULL, '2024-05-23 10:27:15');
INSERT INTO `audit` VALUES (50, 'Item', 13, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:27:15', NULL, '2024-05-23 10:27:15');
INSERT INTO `audit` VALUES (51, 'Item', 14, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:27:15', NULL, '2024-05-23 10:27:15');
INSERT INTO `audit` VALUES (52, 'Item', 15, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:27:15', NULL, '2024-05-23 10:27:15');
INSERT INTO `audit` VALUES (53, 'Item', 16, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:27:15', NULL, '2024-05-23 10:27:15');
INSERT INTO `audit` VALUES (54, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:27:15', NULL, '2024-05-23 10:27:15');
INSERT INTO `audit` VALUES (55, 'Item', 17, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:11', NULL, '2024-05-23 10:28:11');
INSERT INTO `audit` VALUES (56, 'Item', 18, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:11', NULL, '2024-05-23 10:28:11');
INSERT INTO `audit` VALUES (57, 'Item', 19, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:11', NULL, '2024-05-23 10:28:11');
INSERT INTO `audit` VALUES (58, 'Item', 20, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:11', NULL, '2024-05-23 10:28:11');
INSERT INTO `audit` VALUES (59, 'Item', 21, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:11', NULL, '2024-05-23 10:28:11');
INSERT INTO `audit` VALUES (60, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:11', NULL, '2024-05-23 10:28:11');
INSERT INTO `audit` VALUES (61, 'Item', 22, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:29', NULL, '2024-05-23 10:28:29');
INSERT INTO `audit` VALUES (62, 'Item', 23, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:29', NULL, '2024-05-23 10:28:29');
INSERT INTO `audit` VALUES (63, 'Item', 24, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:29', NULL, '2024-05-23 10:28:29');
INSERT INTO `audit` VALUES (64, 'Item', 25, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:29', NULL, '2024-05-23 10:28:29');
INSERT INTO `audit` VALUES (65, 'Item', 26, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:29', NULL, '2024-05-23 10:28:29');
INSERT INTO `audit` VALUES (66, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:29', NULL, '2024-05-23 10:28:29');
INSERT INTO `audit` VALUES (67, 'Item', 27, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:58', NULL, '2024-05-23 10:28:58');
INSERT INTO `audit` VALUES (68, 'Item', 28, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:58', NULL, '2024-05-23 10:28:58');
INSERT INTO `audit` VALUES (69, 'Item', 29, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:58', NULL, '2024-05-23 10:28:58');
INSERT INTO `audit` VALUES (70, 'Item', 30, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:58', NULL, '2024-05-23 10:28:58');
INSERT INTO `audit` VALUES (71, 'Item', 31, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:58', NULL, '2024-05-23 10:28:58');
INSERT INTO `audit` VALUES (72, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:58', NULL, '2024-05-23 10:28:58');
INSERT INTO `audit` VALUES (73, 'Item', 32, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:29:26', NULL, '2024-05-23 10:29:26');
INSERT INTO `audit` VALUES (74, 'Item', 33, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:29:26', NULL, '2024-05-23 10:29:26');
INSERT INTO `audit` VALUES (75, 'Item', 34, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:29:26', NULL, '2024-05-23 10:29:26');
INSERT INTO `audit` VALUES (76, 'Item', 35, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:29:26', NULL, '2024-05-23 10:29:26');
INSERT INTO `audit` VALUES (77, 'Item', 36, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:29:26', NULL, '2024-05-23 10:29:26');
INSERT INTO `audit` VALUES (78, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:29:26', NULL, '2024-05-23 10:29:26');
INSERT INTO `audit` VALUES (79, 'Item', 37, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:30:30', NULL, '2024-05-23 10:30:30');
INSERT INTO `audit` VALUES (80, 'Item', 38, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:30:30', NULL, '2024-05-23 10:30:30');
INSERT INTO `audit` VALUES (81, 'Item', 39, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:30:30', NULL, '2024-05-23 10:30:30');
INSERT INTO `audit` VALUES (82, 'Item', 40, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:30:30', NULL, '2024-05-23 10:30:30');
INSERT INTO `audit` VALUES (83, 'Item', 41, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:30:30', NULL, '2024-05-23 10:30:30');
INSERT INTO `audit` VALUES (84, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:30:30', NULL, '2024-05-23 10:30:30');
INSERT INTO `audit` VALUES (85, 'Item', 42, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:10', NULL, '2024-05-23 10:31:10');
INSERT INTO `audit` VALUES (86, 'Item', 43, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:10', NULL, '2024-05-23 10:31:10');
INSERT INTO `audit` VALUES (87, 'Item', 44, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:10', NULL, '2024-05-23 10:31:10');
INSERT INTO `audit` VALUES (88, 'Item', 45, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:10', NULL, '2024-05-23 10:31:10');
INSERT INTO `audit` VALUES (89, 'Item', 46, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:10', NULL, '2024-05-23 10:31:10');
INSERT INTO `audit` VALUES (90, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:10', NULL, '2024-05-23 10:31:10');
INSERT INTO `audit` VALUES (91, 'Item', 47, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:32', NULL, '2024-05-23 10:31:32');
INSERT INTO `audit` VALUES (92, 'Item', 48, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:32', NULL, '2024-05-23 10:31:32');
INSERT INTO `audit` VALUES (93, 'Item', 49, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:32', NULL, '2024-05-23 10:31:32');
INSERT INTO `audit` VALUES (94, 'Item', 50, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:32', NULL, '2024-05-23 10:31:32');
INSERT INTO `audit` VALUES (95, 'Item', 51, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:32', NULL, '2024-05-23 10:31:32');
INSERT INTO `audit` VALUES (96, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:32', NULL, '2024-05-23 10:31:32');
INSERT INTO `audit` VALUES (97, 'Item', 52, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:04', NULL, '2024-05-23 10:32:04');
INSERT INTO `audit` VALUES (98, 'Item', 53, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:04', NULL, '2024-05-23 10:32:04');
INSERT INTO `audit` VALUES (99, 'Item', 54, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:04', NULL, '2024-05-23 10:32:04');
INSERT INTO `audit` VALUES (100, 'Item', 55, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:04', NULL, '2024-05-23 10:32:04');
INSERT INTO `audit` VALUES (101, 'Item', 56, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:04', NULL, '2024-05-23 10:32:04');
INSERT INTO `audit` VALUES (102, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:04', NULL, '2024-05-23 10:32:04');
INSERT INTO `audit` VALUES (103, 'Item', 57, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:29', NULL, '2024-05-23 10:32:29');
INSERT INTO `audit` VALUES (104, 'Item', 58, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:29', NULL, '2024-05-23 10:32:29');
INSERT INTO `audit` VALUES (105, 'Item', 59, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:29', NULL, '2024-05-23 10:32:29');
INSERT INTO `audit` VALUES (106, 'Item', 60, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:29', NULL, '2024-05-23 10:32:29');
INSERT INTO `audit` VALUES (107, 'Item', 61, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:29', NULL, '2024-05-23 10:32:29');
INSERT INTO `audit` VALUES (108, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:29', NULL, '2024-05-23 10:32:29');
INSERT INTO `audit` VALUES (109, 'Item', 62, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:48', NULL, '2024-05-23 10:32:48');
INSERT INTO `audit` VALUES (110, 'Item', 63, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:48', NULL, '2024-05-23 10:32:48');
INSERT INTO `audit` VALUES (111, 'Item', 64, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:48', NULL, '2024-05-23 10:32:48');
INSERT INTO `audit` VALUES (112, 'Item', 65, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:48', NULL, '2024-05-23 10:32:48');
INSERT INTO `audit` VALUES (113, 'Item', 66, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:48', NULL, '2024-05-23 10:32:48');
INSERT INTO `audit` VALUES (114, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:48', NULL, '2024-05-23 10:32:48');
INSERT INTO `audit` VALUES (115, 'Item', 67, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:09', NULL, '2024-05-23 10:33:09');
INSERT INTO `audit` VALUES (116, 'Item', 68, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:09', NULL, '2024-05-23 10:33:09');
INSERT INTO `audit` VALUES (117, 'Item', 69, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:09', NULL, '2024-05-23 10:33:09');
INSERT INTO `audit` VALUES (118, 'Item', 70, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:09', NULL, '2024-05-23 10:33:09');
INSERT INTO `audit` VALUES (119, 'Item', 71, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:09', NULL, '2024-05-23 10:33:09');
INSERT INTO `audit` VALUES (120, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:09', NULL, '2024-05-23 10:33:09');
INSERT INTO `audit` VALUES (121, 'Item', 72, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:29', NULL, '2024-05-23 10:33:29');
INSERT INTO `audit` VALUES (122, 'Item', 73, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:29', NULL, '2024-05-23 10:33:29');
INSERT INTO `audit` VALUES (123, 'Item', 74, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:29', NULL, '2024-05-23 10:33:29');
INSERT INTO `audit` VALUES (124, 'Item', 75, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:29', NULL, '2024-05-23 10:33:29');
INSERT INTO `audit` VALUES (125, 'Item', 76, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:29', NULL, '2024-05-23 10:33:29');
INSERT INTO `audit` VALUES (126, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:29', NULL, '2024-05-23 10:33:29');
INSERT INTO `audit` VALUES (127, 'Item', 77, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:51', NULL, '2024-05-23 10:33:51');
INSERT INTO `audit` VALUES (128, 'Item', 78, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:51', NULL, '2024-05-23 10:33:51');
INSERT INTO `audit` VALUES (129, 'Item', 79, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:51', NULL, '2024-05-23 10:33:51');
INSERT INTO `audit` VALUES (130, 'Item', 80, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:51', NULL, '2024-05-23 10:33:51');
INSERT INTO `audit` VALUES (131, 'Item', 81, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:51', NULL, '2024-05-23 10:33:51');
INSERT INTO `audit` VALUES (132, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:51', NULL, '2024-05-23 10:33:51');
INSERT INTO `audit` VALUES (133, 'Item', 82, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:20', NULL, '2024-05-23 10:34:20');
INSERT INTO `audit` VALUES (134, 'Item', 83, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:20', NULL, '2024-05-23 10:34:20');
INSERT INTO `audit` VALUES (135, 'Item', 84, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:20', NULL, '2024-05-23 10:34:20');
INSERT INTO `audit` VALUES (136, 'Item', 85, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:20', NULL, '2024-05-23 10:34:20');
INSERT INTO `audit` VALUES (137, 'Item', 86, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:20', NULL, '2024-05-23 10:34:20');
INSERT INTO `audit` VALUES (138, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:20', NULL, '2024-05-23 10:34:20');
INSERT INTO `audit` VALUES (139, 'Item', 11, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:50', NULL, '2024-05-23 10:34:50');
INSERT INTO `audit` VALUES (140, 'Item', 16, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:59', NULL, '2024-05-23 10:34:59');
INSERT INTO `audit` VALUES (141, 'Item', 21, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:35:06', NULL, '2024-05-23 10:35:06');
INSERT INTO `audit` VALUES (142, 'Item', 26, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:35:13', NULL, '2024-05-23 10:35:13');
INSERT INTO `audit` VALUES (143, 'Item', 31, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:35:21', NULL, '2024-05-23 10:35:21');
INSERT INTO `audit` VALUES (144, 'Item', 36, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:35:32', NULL, '2024-05-23 10:35:32');
INSERT INTO `audit` VALUES (145, 'Item', 41, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:35:40', NULL, '2024-05-23 10:35:40');
INSERT INTO `audit` VALUES (146, 'Item', 46, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:35:47', NULL, '2024-05-23 10:35:47');
INSERT INTO `audit` VALUES (147, 'Item', 51, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:35:55', NULL, '2024-05-23 10:35:55');
INSERT INTO `audit` VALUES (148, 'Item', 56, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:36:02', NULL, '2024-05-23 10:36:02');
INSERT INTO `audit` VALUES (149, 'Item', 61, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:36:11', NULL, '2024-05-23 10:36:11');
INSERT INTO `audit` VALUES (150, 'Item', 66, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:36:19', NULL, '2024-05-23 10:36:19');
INSERT INTO `audit` VALUES (151, 'Item', 71, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:36:27', NULL, '2024-05-23 10:36:27');
INSERT INTO `audit` VALUES (152, 'Item', 76, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:36:39', NULL, '2024-05-23 10:36:39');
INSERT INTO `audit` VALUES (153, 'Item', 81, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:36:46', NULL, '2024-05-23 10:36:46');
INSERT INTO `audit` VALUES (154, 'Item', 86, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:36:53', NULL, '2024-05-23 10:36:53');
INSERT INTO `audit` VALUES (155, 'Item', 87, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:25', NULL, '2024-05-23 10:37:25');
INSERT INTO `audit` VALUES (156, 'Item', 88, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:25', NULL, '2024-05-23 10:37:25');
INSERT INTO `audit` VALUES (157, 'Item', 89, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:25', NULL, '2024-05-23 10:37:25');
INSERT INTO `audit` VALUES (158, 'Item', 90, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:25', NULL, '2024-05-23 10:37:25');
INSERT INTO `audit` VALUES (159, 'Item', 91, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:25', NULL, '2024-05-23 10:37:25');
INSERT INTO `audit` VALUES (160, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:25', NULL, '2024-05-23 10:37:25');
INSERT INTO `audit` VALUES (161, 'Item', 91, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:31', NULL, '2024-05-23 10:37:31');
INSERT INTO `audit` VALUES (162, 'Item', 87, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:42', NULL, '2024-05-23 10:37:42');
INSERT INTO `audit` VALUES (163, 'Item', 92, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', NULL, '2024-05-28 14:00:24');
INSERT INTO `audit` VALUES (164, 'Item', 93, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', NULL, '2024-05-28 14:00:24');
INSERT INTO `audit` VALUES (165, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', NULL, '2024-05-28 14:00:24');
INSERT INTO `audit` VALUES (166, 'Item', 3, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', NULL, '2024-05-28 14:00:24');
INSERT INTO `audit` VALUES (167, 'Item', 5, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', NULL, '2024-05-28 14:00:24');
INSERT INTO `audit` VALUES (168, 'Item', 6, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', NULL, '2024-05-28 14:00:24');
INSERT INTO `audit` VALUES (169, 'ItemSet', NULL, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', NULL, '2024-05-28 14:00:24');
INSERT INTO `audit` VALUES (170, 'Item', 93, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:34', NULL, '2024-05-28 14:00:34');
INSERT INTO `audit` VALUES (171, 'Release', 2, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:06:25', NULL, '2024-05-28 14:06:25');
INSERT INTO `audit` VALUES (172, 'ReleaseHistory', 2, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:06:25', NULL, '2024-05-28 14:06:25');
INSERT INTO `audit` VALUES (173, 'Release', 3, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:06:31', NULL, '2024-05-28 14:06:31');
INSERT INTO `audit` VALUES (174, 'ReleaseHistory', 3, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:06:31', NULL, '2024-05-28 14:06:31');
INSERT INTO `audit` VALUES (175, 'Item', 92, 'UPDATE', NULL, b'0', 0, 'apollo', '2024-05-28 14:13:09', NULL, '2024-05-28 14:13:09');
INSERT INTO `audit` VALUES (176, 'Release', 4, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:13:12', NULL, '2024-05-28 14:13:12');
INSERT INTO `audit` VALUES (177, 'ReleaseHistory', 4, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 14:13:12', NULL, '2024-05-28 14:13:12');
INSERT INTO `audit` VALUES (178, 'Item', 94, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:05:17', NULL, '2024-05-28 17:05:17');
INSERT INTO `audit` VALUES (179, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:05:17', NULL, '2024-05-28 17:05:17');
INSERT INTO `audit` VALUES (180, 'Release', 5, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:07:10', NULL, '2024-05-28 17:07:10');
INSERT INTO `audit` VALUES (181, 'ReleaseHistory', 5, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:07:10', NULL, '2024-05-28 17:07:10');
INSERT INTO `audit` VALUES (182, 'Item', 95, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:22:02', NULL, '2024-05-28 17:22:02');
INSERT INTO `audit` VALUES (183, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:22:02', NULL, '2024-05-28 17:22:02');
INSERT INTO `audit` VALUES (184, 'Release', 6, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:25:01', NULL, '2024-05-28 17:25:01');
INSERT INTO `audit` VALUES (185, 'ReleaseHistory', 6, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-28 17:25:01', NULL, '2024-05-28 17:25:01');
INSERT INTO `audit` VALUES (186, 'Item', 96, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:17', NULL, '2024-05-29 08:22:17');
INSERT INTO `audit` VALUES (187, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:17', NULL, '2024-05-29 08:22:17');
INSERT INTO `audit` VALUES (188, 'Release', 7, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:21', NULL, '2024-05-29 08:22:21');
INSERT INTO `audit` VALUES (189, 'ReleaseHistory', 7, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:21', NULL, '2024-05-29 08:22:21');
INSERT INTO `audit` VALUES (190, 'Item', 97, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:39', NULL, '2024-05-29 08:22:39');
INSERT INTO `audit` VALUES (191, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:39', NULL, '2024-05-29 08:22:39');
INSERT INTO `audit` VALUES (192, 'Release', 8, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:23:36', NULL, '2024-05-29 08:23:36');
INSERT INTO `audit` VALUES (193, 'ReleaseHistory', 8, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:23:36', NULL, '2024-05-29 08:23:36');
INSERT INTO `audit` VALUES (194, 'Item', 98, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:09', NULL, '2024-05-29 08:24:09');
INSERT INTO `audit` VALUES (195, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:09', NULL, '2024-05-29 08:24:09');
INSERT INTO `audit` VALUES (196, 'Item', 99, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:44', NULL, '2024-05-29 08:24:44');
INSERT INTO `audit` VALUES (197, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:44', NULL, '2024-05-29 08:24:44');
INSERT INTO `audit` VALUES (198, 'Item', 100, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:59', NULL, '2024-05-29 08:24:59');
INSERT INTO `audit` VALUES (199, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:59', NULL, '2024-05-29 08:24:59');
INSERT INTO `audit` VALUES (200, 'Item', 101, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:13', NULL, '2024-05-29 08:25:13');
INSERT INTO `audit` VALUES (201, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:13', NULL, '2024-05-29 08:25:13');
INSERT INTO `audit` VALUES (202, 'Item', 102, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:34', NULL, '2024-05-29 08:25:34');
INSERT INTO `audit` VALUES (203, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:34', NULL, '2024-05-29 08:25:34');
INSERT INTO `audit` VALUES (204, 'Item', 103, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:49', NULL, '2024-05-29 08:25:49');
INSERT INTO `audit` VALUES (205, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:49', NULL, '2024-05-29 08:25:49');
INSERT INTO `audit` VALUES (206, 'Item', 104, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:07', NULL, '2024-05-29 08:26:07');
INSERT INTO `audit` VALUES (207, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:07', NULL, '2024-05-29 08:26:07');
INSERT INTO `audit` VALUES (208, 'Item', 105, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:21', NULL, '2024-05-29 08:26:21');
INSERT INTO `audit` VALUES (209, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:21', NULL, '2024-05-29 08:26:21');
INSERT INTO `audit` VALUES (210, 'Item', 106, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:49', NULL, '2024-05-29 08:26:49');
INSERT INTO `audit` VALUES (211, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:49', NULL, '2024-05-29 08:26:49');
INSERT INTO `audit` VALUES (212, 'Item', 107, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:03', NULL, '2024-05-29 08:27:03');
INSERT INTO `audit` VALUES (213, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:03', NULL, '2024-05-29 08:27:03');
INSERT INTO `audit` VALUES (214, 'Item', 108, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:20', NULL, '2024-05-29 08:27:20');
INSERT INTO `audit` VALUES (215, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:20', NULL, '2024-05-29 08:27:20');
INSERT INTO `audit` VALUES (216, 'Item', 109, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:40', NULL, '2024-05-29 08:27:40');
INSERT INTO `audit` VALUES (217, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:40', NULL, '2024-05-29 08:27:40');
INSERT INTO `audit` VALUES (218, 'Item', 110, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:56', NULL, '2024-05-29 08:27:56');
INSERT INTO `audit` VALUES (219, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:56', NULL, '2024-05-29 08:27:56');
INSERT INTO `audit` VALUES (220, 'Item', 111, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:28:14', NULL, '2024-05-29 08:28:14');
INSERT INTO `audit` VALUES (221, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:28:14', NULL, '2024-05-29 08:28:14');
INSERT INTO `audit` VALUES (222, 'Item', 112, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:28:30', NULL, '2024-05-29 08:28:30');
INSERT INTO `audit` VALUES (223, 'ItemSet', NULL, 'INSERT', NULL, b'0', 0, 'apollo', '2024-05-29 08:28:30', NULL, '2024-05-29 08:28:30');

-- ----------------------------
-- Table structure for auditlog
-- ----------------------------
DROP TABLE IF EXISTS `auditlog`;
CREATE TABLE `auditlog`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TraceId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '链路全局唯一ID',
  `SpanId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '跨度ID',
  `ParentSpanId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '父跨度ID',
  `FollowsFromSpanId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上一个兄弟跨度ID',
  `Operator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'anonymous' COMMENT '操作人',
  `OpType` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '操作类型',
  `OpName` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '操作名称',
  `Description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_TraceId`(`TraceId` ASC) USING BTREE,
  INDEX `IX_OpName`(`OpName` ASC) USING BTREE,
  INDEX `IX_DataChange_CreatedTime`(`DataChange_CreatedTime` ASC) USING BTREE,
  INDEX `IX_Operator`(`Operator` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审计日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auditlog
-- ----------------------------
INSERT INTO `auditlog` VALUES (1, 'd4720d817eb94815937b98a4307d841a', 'e686b6a995ab4e78824ad082162dd680', 'e281187e88cb4b158ce879806e5df483', NULL, 'apollo', 'UPDATE', 'App.update', 'no description', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');

-- ----------------------------
-- Table structure for auditlogdatainfluence
-- ----------------------------
DROP TABLE IF EXISTS `auditlogdatainfluence`;
CREATE TABLE `auditlogdatainfluence`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `SpanId` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '跨度ID',
  `InfluenceEntityId` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '记录ID',
  `InfluenceEntityName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '表名',
  `FieldName` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段名称',
  `FieldOldValue` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段旧值',
  `FieldNewValue` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字段新值',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_SpanId`(`SpanId` ASC) USING BTREE,
  INDEX `IX_DataChange_CreatedTime`(`DataChange_CreatedTime` ASC) USING BTREE,
  INDEX `IX_EntityId`(`InfluenceEntityId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审计日志数据变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auditlogdatainfluence
-- ----------------------------
INSERT INTO `auditlogdatainfluence` VALUES (1, 'e686b6a995ab4e78824ad082162dd680', '1', 'App', 'Name', NULL, '企业信息一体化平台', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');
INSERT INTO `auditlogdatainfluence` VALUES (2, 'e686b6a995ab4e78824ad082162dd680', '1', 'App', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');

-- ----------------------------
-- Table structure for cluster
-- ----------------------------
DROP TABLE IF EXISTS `cluster`;
CREATE TABLE `cluster`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '集群名字',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'App id',
  `ParentClusterId` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '父cluster',
  `Comment` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_AppId_Name_DeletedAt`(`AppId` ASC, `Name` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `IX_ParentClusterId`(`ParentClusterId` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '集群' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cluster
-- ----------------------------
INSERT INTO `cluster` VALUES (1, 'default', 'EIS', 0, NULL, b'0', 0, 'default', '2024-05-23 01:05:08', '', '2024-05-23 02:01:04');

-- ----------------------------
-- Table structure for commit
-- ----------------------------
DROP TABLE IF EXISTS `commit`;
CREATE TABLE `commit`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ChangeSets` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '修改变更集',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `NamespaceName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `Comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `AppId`(`AppId` ASC) USING BTREE,
  INDEX `ClusterName`(`ClusterName`(191) ASC) USING BTREE,
  INDEX `NamespaceName`(`NamespaceName`(191) ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'commit 历史表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of commit
-- ----------------------------
INSERT INTO `commit` VALUES (1, '{\"createItems\":[],\"updateItems\":[],\"deleteItems\":[{\"namespaceId\":1,\"key\":\"timeout\",\"type\":0,\"value\":\"100\",\"comment\":\"sample timeout配置\",\"lineNum\":1,\"id\":1,\"isDeleted\":true,\"deletedAt\":1716429963489,\"dataChangeCreatedBy\":\"default\",\"dataChangeCreatedTime\":\"2024-05-23 01:05:08\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:06:03\"}]}', 'EIS', 'default', 'application', NULL, b'0', 0, 'apollo', '2024-05-23 10:06:03', 'apollo', '2024-05-23 10:06:03');
INSERT INTO `commit` VALUES (2, '{\"createItems\":[{\"namespaceId\":1,\"key\":\"Swagger.Directory\",\"type\":0,\"value\":\"E:\\\\01Kesiau\\\\EIS\\\\.swagger\",\"comment\":\"\",\"lineNum\":1,\"id\":2,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"},{\"namespaceId\":1,\"key\":\"DataBase.postgresSql\",\"type\":0,\"value\":\"Host\\u003dlocalhost;Port\\u003d5432;Database\\u003deis.base;Username\\u003dpostgres;Password\\u003dadmin@123;\",\"comment\":\"\",\"lineNum\":2,\"id\":3,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"},{\"namespaceId\":1,\"key\":\"IdentityServer.Url\",\"type\":0,\"value\":\"http://localhost:5001\",\"comment\":\"\",\"lineNum\":3,\"id\":4,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"},{\"namespaceId\":1,\"key\":\"Exceptionless.ServerUrl\",\"type\":0,\"value\":\"http://localhost:4000\",\"comment\":\"\",\"lineNum\":4,\"id\":5,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"},{\"namespaceId\":1,\"key\":\"Exceptionless.ApiKey\",\"type\":0,\"value\":\"5W7DPZJgeh0TnAFjd8XMyGDXSguMTcfOC5sSjPpx\",\"comment\":\"\",\"lineNum\":5,\"id\":6,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'application', NULL, b'0', 0, 'apollo', '2024-05-23 10:11:25', 'apollo', '2024-05-23 10:11:25');
INSERT INTO `commit` VALUES (3, '{\"createItems\":[{\"namespaceId\":2,\"key\":\"Service.Name\",\"type\":0,\"value\":\"网关服务\",\"comment\":\"\",\"lineNum\":1,\"id\":7,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:12:02\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:12:02\"},{\"namespaceId\":2,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":8,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:12:02\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:12:02\"},{\"namespaceId\":2,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":9,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:12:02\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:12:02\"},{\"namespaceId\":2,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":10,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:12:02\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:12:02\"},{\"namespaceId\":2,\"key\":\"Service.Port\",\"type\":0,\"value\":\"5000\",\"comment\":\"\",\"lineNum\":5,\"id\":11,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:12:02\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:12:02\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'GateWayService', NULL, b'0', 0, 'apollo', '2024-05-23 10:12:02', 'apollo', '2024-05-23 10:12:02');
INSERT INTO `commit` VALUES (4, '{\"createItems\":[{\"namespaceId\":3,\"key\":\"Service.Name\",\"type\":0,\"value\":\"鉴权服务\",\"comment\":\"\",\"lineNum\":1,\"id\":12,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:27:14\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:27:14\"},{\"namespaceId\":3,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":13,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:27:14\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:27:14\"},{\"namespaceId\":3,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":14,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:27:14\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:27:14\"},{\"namespaceId\":3,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":15,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:27:14\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:27:14\"},{\"namespaceId\":3,\"key\":\"Service.Port\",\"type\":0,\"value\":\"5001\",\"comment\":\"\",\"lineNum\":5,\"id\":16,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:27:14\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:27:14\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'AuthService', NULL, b'0', 0, 'apollo', '2024-05-23 10:27:15', 'apollo', '2024-05-23 10:27:15');
INSERT INTO `commit` VALUES (5, '{\"createItems\":[{\"namespaceId\":4,\"key\":\"Service.Name\",\"type\":0,\"value\":\"管理服务\",\"comment\":\"\",\"lineNum\":1,\"id\":17,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:10\"},{\"namespaceId\":4,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":18,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:10\"},{\"namespaceId\":4,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":19,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:10\"},{\"namespaceId\":4,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":20,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:10\"},{\"namespaceId\":4,\"key\":\"Service.Port\",\"type\":0,\"value\":\"5003\",\"comment\":\"\",\"lineNum\":5,\"id\":21,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:10\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'AdminService', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:11', 'apollo', '2024-05-23 10:28:11');
INSERT INTO `commit` VALUES (6, '{\"createItems\":[{\"namespaceId\":5,\"key\":\"Service.Name\",\"type\":0,\"value\":\"基础服务\",\"comment\":\"\",\"lineNum\":1,\"id\":22,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:29\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:29\"},{\"namespaceId\":5,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":23,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:29\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:29\"},{\"namespaceId\":5,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":24,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:29\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:29\"},{\"namespaceId\":5,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":25,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:29\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:29\"},{\"namespaceId\":5,\"key\":\"Service.Port\",\"type\":0,\"value\":\"5002\",\"comment\":\"\",\"lineNum\":5,\"id\":26,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:29\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:29\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'BaseService', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:29', 'apollo', '2024-05-23 10:28:29');
INSERT INTO `commit` VALUES (7, '{\"createItems\":[{\"namespaceId\":6,\"key\":\"Service.Name\",\"type\":0,\"value\":\"租户服务\",\"comment\":\"\",\"lineNum\":1,\"id\":27,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:57\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:57\"},{\"namespaceId\":6,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":28,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:57\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:57\"},{\"namespaceId\":6,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":29,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:57\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:57\"},{\"namespaceId\":6,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":30,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:57\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:57\"},{\"namespaceId\":6,\"key\":\"Service.Port\",\"type\":0,\"value\":\"5004\",\"comment\":\"\",\"lineNum\":5,\"id\":31,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:28:57\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:28:57\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'BackService', NULL, b'0', 0, 'apollo', '2024-05-23 10:28:58', 'apollo', '2024-05-23 10:28:58');
INSERT INTO `commit` VALUES (8, '{\"createItems\":[{\"namespaceId\":7,\"key\":\"Service.Name\",\"type\":0,\"value\":\"编码服务\",\"comment\":\"\",\"lineNum\":1,\"id\":32,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:29:26\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:29:26\"},{\"namespaceId\":7,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":33,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:29:26\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:29:26\"},{\"namespaceId\":7,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":34,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:29:26\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:29:26\"},{\"namespaceId\":7,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":35,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:29:26\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:29:26\"},{\"namespaceId\":7,\"key\":\"Service.Port\",\"type\":0,\"value\":\"5005\",\"comment\":\"\",\"lineNum\":5,\"id\":36,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:29:26\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:29:26\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'CodeService', NULL, b'0', 0, 'apollo', '2024-05-23 10:29:26', 'apollo', '2024-05-23 10:29:26');
INSERT INTO `commit` VALUES (9, '{\"createItems\":[{\"namespaceId\":8,\"key\":\"Service.Name\",\"type\":0,\"value\":\"定时服务\",\"comment\":\"\",\"lineNum\":1,\"id\":37,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:30:30\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:30:30\"},{\"namespaceId\":8,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":38,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:30:30\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:30:30\"},{\"namespaceId\":8,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":39,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:30:30\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:30:30\"},{\"namespaceId\":8,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":40,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:30:30\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:30:30\"},{\"namespaceId\":8,\"key\":\"Service.Port\",\"type\":0,\"value\":\"5009\",\"comment\":\"\",\"lineNum\":5,\"id\":41,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:30:30\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:30:30\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'TaskService', NULL, b'0', 0, 'apollo', '2024-05-23 10:30:30', 'apollo', '2024-05-23 10:30:30');
INSERT INTO `commit` VALUES (10, '{\"createItems\":[{\"namespaceId\":9,\"key\":\"Service.Name\",\"type\":0,\"value\":\"企业管理服务\",\"comment\":\"\",\"lineNum\":1,\"id\":42,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:10\"},{\"namespaceId\":9,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":43,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:10\"},{\"namespaceId\":9,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":44,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:10\"},{\"namespaceId\":9,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":45,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:10\"},{\"namespaceId\":9,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6001\",\"comment\":\"\",\"lineNum\":5,\"id\":46,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:10\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:10\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'ERPSerivce', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:10', 'apollo', '2024-05-23 10:31:10');
INSERT INTO `commit` VALUES (11, '{\"createItems\":[{\"namespaceId\":10,\"key\":\"Service.Name\",\"type\":0,\"value\":\"办公自动化服务\",\"comment\":\"\",\"lineNum\":1,\"id\":47,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:32\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:32\"},{\"namespaceId\":10,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":48,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:32\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:32\"},{\"namespaceId\":10,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":49,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:32\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:32\"},{\"namespaceId\":10,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":50,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:32\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:32\"},{\"namespaceId\":10,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6002\",\"comment\":\"\",\"lineNum\":5,\"id\":51,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:31:32\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:31:32\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'OAService', NULL, b'0', 0, 'apollo', '2024-05-23 10:31:32', 'apollo', '2024-05-23 10:31:32');
INSERT INTO `commit` VALUES (12, '{\"createItems\":[{\"namespaceId\":11,\"key\":\"Service.Name\",\"type\":0,\"value\":\"人事管理服务\",\"comment\":\"\",\"lineNum\":1,\"id\":52,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:03\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:03\"},{\"namespaceId\":11,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":53,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:03\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:03\"},{\"namespaceId\":11,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":54,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:03\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:03\"},{\"namespaceId\":11,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":55,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:03\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:03\"},{\"namespaceId\":11,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6003\",\"comment\":\"\",\"lineNum\":5,\"id\":56,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:03\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:03\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'HRService', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:04', 'apollo', '2024-05-23 10:32:04');
INSERT INTO `commit` VALUES (13, '{\"createItems\":[{\"namespaceId\":12,\"key\":\"Service.Name\",\"type\":0,\"value\":\"项目管理服务\",\"comment\":\"\",\"lineNum\":1,\"id\":57,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:28\"},{\"namespaceId\":12,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":58,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:28\"},{\"namespaceId\":12,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":59,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:28\"},{\"namespaceId\":12,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":60,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:28\"},{\"namespaceId\":12,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6004\",\"comment\":\"\",\"lineNum\":5,\"id\":61,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:28\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'PLMService', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:29', 'apollo', '2024-05-23 10:32:29');
INSERT INTO `commit` VALUES (14, '{\"createItems\":[{\"namespaceId\":13,\"key\":\"Service.Name\",\"type\":0,\"value\":\"知识库服务\",\"comment\":\"\",\"lineNum\":1,\"id\":62,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:48\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:48\"},{\"namespaceId\":13,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":63,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:48\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:48\"},{\"namespaceId\":13,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":64,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:48\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:48\"},{\"namespaceId\":13,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":65,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:48\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:48\"},{\"namespaceId\":13,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6005\",\"comment\":\"\",\"lineNum\":5,\"id\":66,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:32:48\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:32:48\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'KMSService', NULL, b'0', 0, 'apollo', '2024-05-23 10:32:48', 'apollo', '2024-05-23 10:32:48');
INSERT INTO `commit` VALUES (15, '{\"createItems\":[{\"namespaceId\":14,\"key\":\"Service.Name\",\"type\":0,\"value\":\"客户管理服务\",\"comment\":\"\",\"lineNum\":1,\"id\":67,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:09\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:09\"},{\"namespaceId\":14,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":68,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:09\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:09\"},{\"namespaceId\":14,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":69,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:09\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:09\"},{\"namespaceId\":14,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":70,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:09\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:09\"},{\"namespaceId\":14,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6006\",\"comment\":\"\",\"lineNum\":5,\"id\":71,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:09\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:09\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'CRMService', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:09', 'apollo', '2024-05-23 10:33:09');
INSERT INTO `commit` VALUES (16, '{\"createItems\":[{\"namespaceId\":15,\"key\":\"Service.Name\",\"type\":0,\"value\":\"供应商管理服务\",\"comment\":\"\",\"lineNum\":1,\"id\":72,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:28\"},{\"namespaceId\":15,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":73,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:28\"},{\"namespaceId\":15,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":74,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:28\"},{\"namespaceId\":15,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":75,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:28\"},{\"namespaceId\":15,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6007\",\"comment\":\"\",\"lineNum\":5,\"id\":76,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:28\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:28\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'SCMService', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:29', 'apollo', '2024-05-23 10:33:29');
INSERT INTO `commit` VALUES (17, '{\"createItems\":[{\"namespaceId\":16,\"key\":\"Service.Name\",\"type\":0,\"value\":\"信息安全服务\",\"comment\":\"\",\"lineNum\":1,\"id\":77,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:50\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:50\"},{\"namespaceId\":16,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":78,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:50\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:50\"},{\"namespaceId\":16,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":79,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:50\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:50\"},{\"namespaceId\":16,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":80,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:50\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:50\"},{\"namespaceId\":16,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6008\",\"comment\":\"\",\"lineNum\":5,\"id\":81,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:33:50\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:33:50\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'ISMSService', NULL, b'0', 0, 'apollo', '2024-05-23 10:33:51', 'apollo', '2024-05-23 10:33:51');
INSERT INTO `commit` VALUES (18, '{\"createItems\":[{\"namespaceId\":17,\"key\":\"Service.Name\",\"type\":0,\"value\":\"报表服务\",\"comment\":\"\",\"lineNum\":1,\"id\":82,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:34:20\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:34:20\"},{\"namespaceId\":17,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":83,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:34:20\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:34:20\"},{\"namespaceId\":17,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":84,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:34:20\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:34:20\"},{\"namespaceId\":17,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":85,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:34:20\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:34:20\"},{\"namespaceId\":17,\"key\":\"Service.Port\",\"type\":0,\"value\":\"6009\",\"comment\":\"\",\"lineNum\":5,\"id\":86,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:34:20\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:34:20\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'BIService', NULL, b'0', 0, 'apollo', '2024-05-23 10:34:20', 'apollo', '2024-05-23 10:34:20');
INSERT INTO `commit` VALUES (19, '{\"createItems\":[{\"namespaceId\":18,\"key\":\"Service.Name\",\"type\":0,\"value\":\"报表服务\",\"comment\":\"\",\"lineNum\":1,\"id\":87,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:37:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:37:24\"},{\"namespaceId\":18,\"key\":\"Service.Version\",\"type\":0,\"value\":\"1.0.0\",\"comment\":\"\",\"lineNum\":2,\"id\":88,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:37:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:37:24\"},{\"namespaceId\":18,\"key\":\"Service.HttpsMetadata\",\"type\":0,\"value\":\"http\",\"comment\":\"\",\"lineNum\":3,\"id\":89,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:37:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:37:24\"},{\"namespaceId\":18,\"key\":\"Service.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":4,\"id\":90,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:37:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:37:24\"},{\"namespaceId\":18,\"key\":\"Service.Port\",\"type\":0,\"value\":\"7000\",\"comment\":\"\",\"lineNum\":5,\"id\":91,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:37:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:37:24\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'AIService', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:25', 'apollo', '2024-05-23 10:37:25');
INSERT INTO `commit` VALUES (20, '{\"createItems\":[],\"updateItems\":[{\"oldItem\":{\"namespaceId\":18,\"key\":\"Service.Name\",\"type\":0,\"value\":\"报表服务\",\"comment\":\"\",\"lineNum\":1,\"id\":87,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:37:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:37:25\"},\"newItem\":{\"namespaceId\":18,\"key\":\"Service.Name\",\"type\":0,\"value\":\"智能服务\",\"comment\":\"\",\"lineNum\":1,\"id\":87,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:37:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:37:42\"}}],\"deleteItems\":[]}', 'EIS', 'default', 'AIService', NULL, b'0', 0, 'apollo', '2024-05-23 10:37:42', 'apollo', '2024-05-23 10:37:42');
INSERT INTO `commit` VALUES (21, '{\"createItems\":[{\"namespaceId\":1,\"key\":\"Consul.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":6,\"id\":92,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-28 14:00:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 14:00:24\"},{\"namespaceId\":1,\"key\":\"Consul.Port\",\"type\":0,\"value\":\"8500\",\"comment\":\"\",\"lineNum\":7,\"id\":93,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-28 14:00:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 14:00:24\"}],\"updateItems\":[{\"oldItem\":{\"namespaceId\":1,\"key\":\"DataBase.postgresSql\",\"type\":0,\"value\":\"Host\\u003dlocalhost;Port\\u003d5432;Database\\u003deis.base;Username\\u003dpostgres;Password\\u003dadmin@123;\",\"comment\":\"\",\"lineNum\":2,\"id\":3,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"},\"newItem\":{\"namespaceId\":1,\"key\":\"DataBase.postgresSql\",\"type\":0,\"value\":\"Host\\u003d101.126.86.21;Port\\u003d5432;Database\\u003deis.base;Username\\u003dpostgres;Password\\u003dadmin@123;\",\"comment\":\"\",\"lineNum\":2,\"id\":3,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 14:00:24\"}},{\"oldItem\":{\"namespaceId\":1,\"key\":\"Exceptionless.ServerUrl\",\"type\":0,\"value\":\"http://localhost:4000\",\"comment\":\"\",\"lineNum\":4,\"id\":5,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"},\"newItem\":{\"namespaceId\":1,\"key\":\"Exceptionless.ServerUrl\",\"type\":0,\"value\":\"http://101.126.86.21:4000\",\"comment\":\"\",\"lineNum\":4,\"id\":5,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 14:00:24\"}},{\"oldItem\":{\"namespaceId\":1,\"key\":\"Exceptionless.ApiKey\",\"type\":0,\"value\":\"5W7DPZJgeh0TnAFjd8XMyGDXSguMTcfOC5sSjPpx\",\"comment\":\"\",\"lineNum\":5,\"id\":6,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-23 10:11:25\"},\"newItem\":{\"namespaceId\":1,\"key\":\"Exceptionless.ApiKey\",\"type\":0,\"value\":\"DVm5PVyjyoFKoOknhH4SFJOUXzWCKAXjOrsudCiU\",\"comment\":\"\",\"lineNum\":5,\"id\":6,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-23 10:11:25\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 14:00:24\"}}],\"deleteItems\":[]}', 'EIS', 'default', 'application', NULL, b'0', 0, 'apollo', '2024-05-28 14:00:24', 'apollo', '2024-05-28 14:00:24');
INSERT INTO `commit` VALUES (22, '{\"createItems\":[],\"updateItems\":[{\"oldItem\":{\"namespaceId\":1,\"key\":\"Consul.IP\",\"type\":0,\"value\":\"localhost\",\"comment\":\"\",\"lineNum\":6,\"id\":92,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-28 14:00:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 14:00:24\"},\"newItem\":{\"namespaceId\":1,\"key\":\"Consul.IP\",\"type\":0,\"value\":\"172.30.73.49\",\"comment\":\"\",\"lineNum\":6,\"id\":92,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-28 14:00:24\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 14:13:08\"}}],\"deleteItems\":[]}', 'EIS', 'default', 'application', NULL, b'0', 0, 'apollo', '2024-05-28 14:13:09', 'apollo', '2024-05-28 14:13:09');
INSERT INTO `commit` VALUES (23, '{\"createItems\":[{\"namespaceId\":1,\"key\":\"Listen.IP\",\"type\":0,\"value\":\"0.0.0.0\",\"comment\":\"\",\"lineNum\":8,\"id\":94,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-28 17:05:17\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 17:05:17\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'application', NULL, b'0', 0, 'apollo', '2024-05-28 17:05:17', 'apollo', '2024-05-28 17:05:17');
INSERT INTO `commit` VALUES (24, '{\"createItems\":[{\"namespaceId\":1,\"key\":\"HealthCheck.IP\",\"type\":0,\"value\":\"172.30.64.1\",\"comment\":\"\",\"lineNum\":9,\"id\":95,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-28 17:22:01\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-28 17:22:01\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'application', NULL, b'0', 0, 'apollo', '2024-05-28 17:22:02', 'apollo', '2024-05-28 17:22:02');
INSERT INTO `commit` VALUES (25, '{\"createItems\":[{\"namespaceId\":2,\"key\":\"Service.Code\",\"type\":0,\"value\":\"GateWayService\",\"comment\":\"\",\"lineNum\":6,\"id\":96,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:22:16\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:22:16\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'GateWayService', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:17', 'apollo', '2024-05-29 08:22:17');
INSERT INTO `commit` VALUES (26, '{\"createItems\":[{\"namespaceId\":3,\"key\":\"Service.Code\",\"type\":0,\"value\":\"AuthService\",\"comment\":\"\",\"lineNum\":6,\"id\":97,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:22:38\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:22:38\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'AuthService', NULL, b'0', 0, 'apollo', '2024-05-29 08:22:39', 'apollo', '2024-05-29 08:22:39');
INSERT INTO `commit` VALUES (27, '{\"createItems\":[{\"namespaceId\":4,\"key\":\"Service.Code\",\"type\":0,\"value\":\"AdminService\",\"comment\":\"\",\"lineNum\":6,\"id\":98,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:24:08\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:24:08\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'AdminService', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:09', 'apollo', '2024-05-29 08:24:09');
INSERT INTO `commit` VALUES (28, '{\"createItems\":[{\"namespaceId\":5,\"key\":\"Service.Code\",\"type\":0,\"value\":\"BaseService\",\"comment\":\"\",\"lineNum\":6,\"id\":99,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:24:44\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:24:44\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'BaseService', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:44', 'apollo', '2024-05-29 08:24:44');
INSERT INTO `commit` VALUES (29, '{\"createItems\":[{\"namespaceId\":6,\"key\":\"Service.Code\",\"type\":0,\"value\":\"BackService\",\"comment\":\"\",\"lineNum\":6,\"id\":100,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:24:58\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:24:58\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'BackService', NULL, b'0', 0, 'apollo', '2024-05-29 08:24:59', 'apollo', '2024-05-29 08:24:59');
INSERT INTO `commit` VALUES (30, '{\"createItems\":[{\"namespaceId\":7,\"key\":\"Service.Code\",\"type\":0,\"value\":\"CodeService\",\"comment\":\"\",\"lineNum\":6,\"id\":101,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:25:12\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:25:12\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'CodeService', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:13', 'apollo', '2024-05-29 08:25:13');
INSERT INTO `commit` VALUES (31, '{\"createItems\":[{\"namespaceId\":8,\"key\":\"Service.Code\",\"type\":0,\"value\":\"TaskService\",\"comment\":\"\",\"lineNum\":6,\"id\":102,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:25:34\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:25:34\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'TaskService', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:34', 'apollo', '2024-05-29 08:25:34');
INSERT INTO `commit` VALUES (32, '{\"createItems\":[{\"namespaceId\":9,\"key\":\"Service.Code\",\"type\":0,\"value\":\"ERPService\",\"comment\":\"\",\"lineNum\":6,\"id\":103,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:25:48\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:25:48\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'ERPSerivce', NULL, b'0', 0, 'apollo', '2024-05-29 08:25:49', 'apollo', '2024-05-29 08:25:49');
INSERT INTO `commit` VALUES (33, '{\"createItems\":[{\"namespaceId\":10,\"key\":\"Service.Code\",\"type\":0,\"value\":\"OAService\",\"comment\":\"\",\"lineNum\":6,\"id\":104,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:26:07\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:26:07\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'OAService', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:07', 'apollo', '2024-05-29 08:26:07');
INSERT INTO `commit` VALUES (34, '{\"createItems\":[{\"namespaceId\":11,\"key\":\"Service.Code\",\"type\":0,\"value\":\"HRService\",\"comment\":\"\",\"lineNum\":6,\"id\":105,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:26:20\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:26:20\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'HRService', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:21', 'apollo', '2024-05-29 08:26:21');
INSERT INTO `commit` VALUES (35, '{\"createItems\":[{\"namespaceId\":12,\"key\":\"Service.Code\",\"type\":0,\"value\":\"PLMService\",\"comment\":\"\",\"lineNum\":6,\"id\":106,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:26:49\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:26:49\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'PLMService', NULL, b'0', 0, 'apollo', '2024-05-29 08:26:49', 'apollo', '2024-05-29 08:26:49');
INSERT INTO `commit` VALUES (36, '{\"createItems\":[{\"namespaceId\":13,\"key\":\"Service.Code\",\"type\":0,\"value\":\"KMSService\",\"comment\":\"\",\"lineNum\":6,\"id\":107,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:27:03\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:27:03\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'KMSService', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:03', 'apollo', '2024-05-29 08:27:03');
INSERT INTO `commit` VALUES (37, '{\"createItems\":[{\"namespaceId\":14,\"key\":\"Service.Code\",\"type\":0,\"value\":\"CRMService\",\"comment\":\"\",\"lineNum\":6,\"id\":108,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:27:20\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:27:20\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'CRMService', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:20', 'apollo', '2024-05-29 08:27:20');
INSERT INTO `commit` VALUES (38, '{\"createItems\":[{\"namespaceId\":15,\"key\":\"Service.Code\",\"type\":0,\"value\":\"SCMService\",\"comment\":\"\",\"lineNum\":6,\"id\":109,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:27:40\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:27:40\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'SCMService', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:40', 'apollo', '2024-05-29 08:27:40');
INSERT INTO `commit` VALUES (39, '{\"createItems\":[{\"namespaceId\":16,\"key\":\"Service.Code\",\"type\":0,\"value\":\"ISMSService\",\"comment\":\"\",\"lineNum\":6,\"id\":110,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:27:56\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:27:56\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'ISMSService', NULL, b'0', 0, 'apollo', '2024-05-29 08:27:56', 'apollo', '2024-05-29 08:27:56');
INSERT INTO `commit` VALUES (40, '{\"createItems\":[{\"namespaceId\":17,\"key\":\"Service.Code\",\"type\":0,\"value\":\"BIService\",\"comment\":\"\",\"lineNum\":6,\"id\":111,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:28:13\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:28:13\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'BIService', NULL, b'0', 0, 'apollo', '2024-05-29 08:28:14', 'apollo', '2024-05-29 08:28:14');
INSERT INTO `commit` VALUES (41, '{\"createItems\":[{\"namespaceId\":18,\"key\":\"Service.Code\",\"type\":0,\"value\":\"AIService\",\"comment\":\"\",\"lineNum\":6,\"id\":112,\"isDeleted\":false,\"deletedAt\":0,\"dataChangeCreatedBy\":\"apollo\",\"dataChangeCreatedTime\":\"2024-05-29 08:28:30\",\"dataChangeLastModifiedBy\":\"apollo\",\"dataChangeLastModifiedTime\":\"2024-05-29 08:28:30\"}],\"updateItems\":[],\"deleteItems\":[]}', 'EIS', 'default', 'AIService', NULL, b'0', 0, 'apollo', '2024-05-29 08:28:30', 'apollo', '2024-05-29 08:28:30');

-- ----------------------------
-- Table structure for grayreleaserule
-- ----------------------------
DROP TABLE IF EXISTS `grayreleaserule`;
CREATE TABLE `grayreleaserule`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
  `NamespaceName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
  `BranchName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'branch name',
  `Rules` varchar(16000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '[]' COMMENT '灰度规则',
  `ReleaseId` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '灰度对应的release',
  `BranchStatus` tinyint NULL DEFAULT 1 COMMENT '灰度分支状态: 0:删除分支,1:正在使用的规则 2：全量发布',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_Namespace`(`AppId` ASC, `ClusterName` ASC, `NamespaceName` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '灰度规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of grayreleaserule
-- ----------------------------

-- ----------------------------
-- Table structure for instance
-- ----------------------------
DROP TABLE IF EXISTS `instance`;
CREATE TABLE `instance`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `DataCenter` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Data Center Name',
  `Ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'instance ip',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `IX_UNIQUE_KEY`(`AppId` ASC, `ClusterName` ASC, `Ip` ASC, `DataCenter` ASC) USING BTREE,
  INDEX `IX_IP`(`Ip` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '使用配置的应用实例' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instance
-- ----------------------------
INSERT INTO `instance` VALUES (1, 'EIS', 'default', '', '10.50.7.107', '2024-05-28 16:08:51', '2024-05-28 16:08:51');

-- ----------------------------
-- Table structure for instanceconfig
-- ----------------------------
DROP TABLE IF EXISTS `instanceconfig`;
CREATE TABLE `instanceconfig`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `InstanceId` int UNSIGNED NULL DEFAULT NULL COMMENT 'Instance Id',
  `ConfigAppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Config App Id',
  `ConfigClusterName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Config Cluster Name',
  `ConfigNamespaceName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Config Namespace Name',
  `ReleaseKey` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '发布的Key',
  `ReleaseDeliveryTime` timestamp NULL DEFAULT NULL COMMENT '配置获取时间',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `IX_UNIQUE_KEY`(`InstanceId` ASC, `ConfigAppId` ASC, `ConfigNamespaceName` ASC) USING BTREE,
  INDEX `IX_ReleaseKey`(`ReleaseKey` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_Valid_Namespace`(`ConfigAppId` ASC, `ConfigClusterName` ASC, `ConfigNamespaceName` ASC, `DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '应用实例的配置信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of instanceconfig
-- ----------------------------
INSERT INTO `instanceconfig` VALUES (1, 1, 'EIS', 'default', 'application', '20240528172501-27fd30c49ef22cef', '2024-05-28 17:25:21', '2024-05-28 16:08:51', '2024-05-29 08:15:18');
INSERT INTO `instanceconfig` VALUES (2, 1, 'EIS', 'default', 'GateWayService', '20240529082221-0ebe30c49efb92b1', '2024-05-29 08:29:26', '2024-05-28 16:08:51', '2024-05-29 08:29:26');
INSERT INTO `instanceconfig` VALUES (3, 1, 'EIS', 'default', 'AuthService', '20240529082335-1e7a30c49efb92b2', '2024-05-29 08:29:30', '2024-05-29 08:29:30', '2024-05-29 08:29:30');

-- ----------------------------
-- Table structure for item
-- ----------------------------
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `NamespaceId` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '集群NamespaceId',
  `Key` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Type` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '配置项类型，0: String，1: Number，2: Boolean，3: JSON',
  `Value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '配置项值',
  `Comment` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '注释',
  `LineNum` int UNSIGNED NULL DEFAULT 0 COMMENT '行号',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_GroupId`(`NamespaceId` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '配置项目' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of item
-- ----------------------------
INSERT INTO `item` VALUES (1, 1, 'timeout', 0, '100', 'sample timeout配置', 1, b'1', 1716429963435, 'default', '2024-05-23 01:05:08', 'apollo', '2024-05-23 10:06:03');
INSERT INTO `item` VALUES (2, 1, 'Swagger.Directory', 0, 'E:\\01Kesiau\\EIS\\.swagger', '', 1, b'0', 0, 'apollo', '2024-05-23 10:11:25', 'apollo', '2024-05-23 10:11:25');
INSERT INTO `item` VALUES (3, 1, 'DataBase.postgresSql', 0, 'Host=101.126.86.21;Port=5432;Database=eis.base;Username=postgres;Password=admin@123;', '', 2, b'0', 0, 'apollo', '2024-05-23 10:11:25', 'apollo', '2024-05-28 14:00:24');
INSERT INTO `item` VALUES (4, 1, 'IdentityServer.Url', 0, 'http://localhost:5001', '', 3, b'0', 0, 'apollo', '2024-05-23 10:11:25', 'apollo', '2024-05-23 10:11:25');
INSERT INTO `item` VALUES (5, 1, 'Exceptionless.ServerUrl', 0, 'http://101.126.86.21:4000', '', 4, b'0', 0, 'apollo', '2024-05-23 10:11:25', 'apollo', '2024-05-28 14:00:24');
INSERT INTO `item` VALUES (6, 1, 'Exceptionless.ApiKey', 0, 'DVm5PVyjyoFKoOknhH4SFJOUXzWCKAXjOrsudCiU', '', 5, b'0', 0, 'apollo', '2024-05-23 10:11:25', 'apollo', '2024-05-28 14:00:24');
INSERT INTO `item` VALUES (7, 2, 'Service.Name', 0, '网关服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:12:02', 'apollo', '2024-05-23 10:12:02');
INSERT INTO `item` VALUES (8, 2, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:12:02', 'apollo', '2024-05-23 10:12:02');
INSERT INTO `item` VALUES (9, 2, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:12:02', 'apollo', '2024-05-23 10:12:02');
INSERT INTO `item` VALUES (10, 2, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:12:02', 'apollo', '2024-05-23 10:12:02');
INSERT INTO `item` VALUES (11, 2, 'Service.Port', 1, '5000', '', 5, b'0', 0, 'apollo', '2024-05-23 10:12:02', 'apollo', '2024-05-23 10:34:50');
INSERT INTO `item` VALUES (12, 3, 'Service.Name', 0, '鉴权服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:27:15', 'apollo', '2024-05-23 10:27:15');
INSERT INTO `item` VALUES (13, 3, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:27:15', 'apollo', '2024-05-23 10:27:15');
INSERT INTO `item` VALUES (14, 3, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:27:15', 'apollo', '2024-05-23 10:27:15');
INSERT INTO `item` VALUES (15, 3, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:27:15', 'apollo', '2024-05-23 10:27:15');
INSERT INTO `item` VALUES (16, 3, 'Service.Port', 1, '5001', '', 5, b'0', 0, 'apollo', '2024-05-23 10:27:15', 'apollo', '2024-05-23 10:34:59');
INSERT INTO `item` VALUES (17, 4, 'Service.Name', 0, '管理服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:28:11', 'apollo', '2024-05-23 10:28:11');
INSERT INTO `item` VALUES (18, 4, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:28:11', 'apollo', '2024-05-23 10:28:11');
INSERT INTO `item` VALUES (19, 4, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:28:11', 'apollo', '2024-05-23 10:28:11');
INSERT INTO `item` VALUES (20, 4, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:28:11', 'apollo', '2024-05-23 10:28:11');
INSERT INTO `item` VALUES (21, 4, 'Service.Port', 1, '5003', '', 5, b'0', 0, 'apollo', '2024-05-23 10:28:11', 'apollo', '2024-05-23 10:35:06');
INSERT INTO `item` VALUES (22, 5, 'Service.Name', 0, '基础服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:28:29', 'apollo', '2024-05-23 10:28:29');
INSERT INTO `item` VALUES (23, 5, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:28:29', 'apollo', '2024-05-23 10:28:29');
INSERT INTO `item` VALUES (24, 5, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:28:29', 'apollo', '2024-05-23 10:28:29');
INSERT INTO `item` VALUES (25, 5, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:28:29', 'apollo', '2024-05-23 10:28:29');
INSERT INTO `item` VALUES (26, 5, 'Service.Port', 1, '5002', '', 5, b'0', 0, 'apollo', '2024-05-23 10:28:29', 'apollo', '2024-05-23 10:35:13');
INSERT INTO `item` VALUES (27, 6, 'Service.Name', 0, '租户服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:28:58', 'apollo', '2024-05-23 10:28:58');
INSERT INTO `item` VALUES (28, 6, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:28:58', 'apollo', '2024-05-23 10:28:58');
INSERT INTO `item` VALUES (29, 6, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:28:58', 'apollo', '2024-05-23 10:28:58');
INSERT INTO `item` VALUES (30, 6, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:28:58', 'apollo', '2024-05-23 10:28:58');
INSERT INTO `item` VALUES (31, 6, 'Service.Port', 1, '5004', '', 5, b'0', 0, 'apollo', '2024-05-23 10:28:58', 'apollo', '2024-05-23 10:35:21');
INSERT INTO `item` VALUES (32, 7, 'Service.Name', 0, '编码服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:29:26', 'apollo', '2024-05-23 10:29:26');
INSERT INTO `item` VALUES (33, 7, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:29:26', 'apollo', '2024-05-23 10:29:26');
INSERT INTO `item` VALUES (34, 7, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:29:26', 'apollo', '2024-05-23 10:29:26');
INSERT INTO `item` VALUES (35, 7, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:29:26', 'apollo', '2024-05-23 10:29:26');
INSERT INTO `item` VALUES (36, 7, 'Service.Port', 1, '5005', '', 5, b'0', 0, 'apollo', '2024-05-23 10:29:26', 'apollo', '2024-05-23 10:35:32');
INSERT INTO `item` VALUES (37, 8, 'Service.Name', 0, '定时服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:30:30', 'apollo', '2024-05-23 10:30:30');
INSERT INTO `item` VALUES (38, 8, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:30:30', 'apollo', '2024-05-23 10:30:30');
INSERT INTO `item` VALUES (39, 8, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:30:30', 'apollo', '2024-05-23 10:30:30');
INSERT INTO `item` VALUES (40, 8, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:30:30', 'apollo', '2024-05-23 10:30:30');
INSERT INTO `item` VALUES (41, 8, 'Service.Port', 1, '5009', '', 5, b'0', 0, 'apollo', '2024-05-23 10:30:30', 'apollo', '2024-05-23 10:35:40');
INSERT INTO `item` VALUES (42, 9, 'Service.Name', 0, '企业管理服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:31:10', 'apollo', '2024-05-23 10:31:10');
INSERT INTO `item` VALUES (43, 9, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:31:10', 'apollo', '2024-05-23 10:31:10');
INSERT INTO `item` VALUES (44, 9, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:31:10', 'apollo', '2024-05-23 10:31:10');
INSERT INTO `item` VALUES (45, 9, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:31:10', 'apollo', '2024-05-23 10:31:10');
INSERT INTO `item` VALUES (46, 9, 'Service.Port', 1, '6001', '', 5, b'0', 0, 'apollo', '2024-05-23 10:31:10', 'apollo', '2024-05-23 10:35:47');
INSERT INTO `item` VALUES (47, 10, 'Service.Name', 0, '办公自动化服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:31:32', 'apollo', '2024-05-23 10:31:32');
INSERT INTO `item` VALUES (48, 10, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:31:32', 'apollo', '2024-05-23 10:31:32');
INSERT INTO `item` VALUES (49, 10, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:31:32', 'apollo', '2024-05-23 10:31:32');
INSERT INTO `item` VALUES (50, 10, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:31:32', 'apollo', '2024-05-23 10:31:32');
INSERT INTO `item` VALUES (51, 10, 'Service.Port', 1, '6002', '', 5, b'0', 0, 'apollo', '2024-05-23 10:31:32', 'apollo', '2024-05-23 10:35:55');
INSERT INTO `item` VALUES (52, 11, 'Service.Name', 0, '人事管理服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:32:04', 'apollo', '2024-05-23 10:32:04');
INSERT INTO `item` VALUES (53, 11, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:32:04', 'apollo', '2024-05-23 10:32:04');
INSERT INTO `item` VALUES (54, 11, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:32:04', 'apollo', '2024-05-23 10:32:04');
INSERT INTO `item` VALUES (55, 11, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:32:04', 'apollo', '2024-05-23 10:32:04');
INSERT INTO `item` VALUES (56, 11, 'Service.Port', 1, '6003', '', 5, b'0', 0, 'apollo', '2024-05-23 10:32:04', 'apollo', '2024-05-23 10:36:02');
INSERT INTO `item` VALUES (57, 12, 'Service.Name', 0, '项目管理服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:32:29', 'apollo', '2024-05-23 10:32:29');
INSERT INTO `item` VALUES (58, 12, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:32:29', 'apollo', '2024-05-23 10:32:29');
INSERT INTO `item` VALUES (59, 12, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:32:29', 'apollo', '2024-05-23 10:32:29');
INSERT INTO `item` VALUES (60, 12, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:32:29', 'apollo', '2024-05-23 10:32:29');
INSERT INTO `item` VALUES (61, 12, 'Service.Port', 1, '6004', '', 5, b'0', 0, 'apollo', '2024-05-23 10:32:29', 'apollo', '2024-05-23 10:36:11');
INSERT INTO `item` VALUES (62, 13, 'Service.Name', 0, '知识库服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:32:48', 'apollo', '2024-05-23 10:32:48');
INSERT INTO `item` VALUES (63, 13, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:32:48', 'apollo', '2024-05-23 10:32:48');
INSERT INTO `item` VALUES (64, 13, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:32:48', 'apollo', '2024-05-23 10:32:48');
INSERT INTO `item` VALUES (65, 13, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:32:48', 'apollo', '2024-05-23 10:32:48');
INSERT INTO `item` VALUES (66, 13, 'Service.Port', 1, '6005', '', 5, b'0', 0, 'apollo', '2024-05-23 10:32:48', 'apollo', '2024-05-23 10:36:19');
INSERT INTO `item` VALUES (67, 14, 'Service.Name', 0, '客户管理服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:33:09', 'apollo', '2024-05-23 10:33:09');
INSERT INTO `item` VALUES (68, 14, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:33:09', 'apollo', '2024-05-23 10:33:09');
INSERT INTO `item` VALUES (69, 14, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:33:09', 'apollo', '2024-05-23 10:33:09');
INSERT INTO `item` VALUES (70, 14, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:33:09', 'apollo', '2024-05-23 10:33:09');
INSERT INTO `item` VALUES (71, 14, 'Service.Port', 1, '6006', '', 5, b'0', 0, 'apollo', '2024-05-23 10:33:09', 'apollo', '2024-05-23 10:36:27');
INSERT INTO `item` VALUES (72, 15, 'Service.Name', 0, '供应商管理服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:33:29', 'apollo', '2024-05-23 10:33:29');
INSERT INTO `item` VALUES (73, 15, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:33:29', 'apollo', '2024-05-23 10:33:29');
INSERT INTO `item` VALUES (74, 15, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:33:29', 'apollo', '2024-05-23 10:33:29');
INSERT INTO `item` VALUES (75, 15, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:33:29', 'apollo', '2024-05-23 10:33:29');
INSERT INTO `item` VALUES (76, 15, 'Service.Port', 1, '6007', '', 5, b'0', 0, 'apollo', '2024-05-23 10:33:29', 'apollo', '2024-05-23 10:36:39');
INSERT INTO `item` VALUES (77, 16, 'Service.Name', 0, '信息安全服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:33:51', 'apollo', '2024-05-23 10:33:51');
INSERT INTO `item` VALUES (78, 16, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:33:51', 'apollo', '2024-05-23 10:33:51');
INSERT INTO `item` VALUES (79, 16, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:33:51', 'apollo', '2024-05-23 10:33:51');
INSERT INTO `item` VALUES (80, 16, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:33:51', 'apollo', '2024-05-23 10:33:51');
INSERT INTO `item` VALUES (81, 16, 'Service.Port', 1, '6008', '', 5, b'0', 0, 'apollo', '2024-05-23 10:33:51', 'apollo', '2024-05-23 10:36:46');
INSERT INTO `item` VALUES (82, 17, 'Service.Name', 0, '报表服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:34:20', 'apollo', '2024-05-23 10:34:20');
INSERT INTO `item` VALUES (83, 17, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:34:20', 'apollo', '2024-05-23 10:34:20');
INSERT INTO `item` VALUES (84, 17, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:34:20', 'apollo', '2024-05-23 10:34:20');
INSERT INTO `item` VALUES (85, 17, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:34:20', 'apollo', '2024-05-23 10:34:20');
INSERT INTO `item` VALUES (86, 17, 'Service.Port', 1, '6009', '', 5, b'0', 0, 'apollo', '2024-05-23 10:34:20', 'apollo', '2024-05-23 10:36:53');
INSERT INTO `item` VALUES (87, 18, 'Service.Name', 0, '智能服务', '', 1, b'0', 0, 'apollo', '2024-05-23 10:37:25', 'apollo', '2024-05-23 10:37:42');
INSERT INTO `item` VALUES (88, 18, 'Service.Version', 0, '1.0.0', '', 2, b'0', 0, 'apollo', '2024-05-23 10:37:25', 'apollo', '2024-05-23 10:37:25');
INSERT INTO `item` VALUES (89, 18, 'Service.HttpsMetadata', 0, 'http', '', 3, b'0', 0, 'apollo', '2024-05-23 10:37:25', 'apollo', '2024-05-23 10:37:25');
INSERT INTO `item` VALUES (90, 18, 'Service.IP', 0, 'localhost', '', 4, b'0', 0, 'apollo', '2024-05-23 10:37:25', 'apollo', '2024-05-23 10:37:25');
INSERT INTO `item` VALUES (91, 18, 'Service.Port', 1, '7000', '', 5, b'0', 0, 'apollo', '2024-05-23 10:37:25', 'apollo', '2024-05-23 10:37:31');
INSERT INTO `item` VALUES (92, 1, 'Consul.IP', 0, '172.30.73.49', '', 6, b'0', 0, 'apollo', '2024-05-28 14:00:24', 'apollo', '2024-05-28 14:13:09');
INSERT INTO `item` VALUES (93, 1, 'Consul.Port', 1, '8500', '', 7, b'0', 0, 'apollo', '2024-05-28 14:00:24', 'apollo', '2024-05-28 14:00:34');
INSERT INTO `item` VALUES (94, 1, 'Listen.IP', 0, '0.0.0.0', '', 8, b'0', 0, 'apollo', '2024-05-28 17:05:17', 'apollo', '2024-05-28 17:05:17');
INSERT INTO `item` VALUES (95, 1, 'HealthCheck.IP', 0, '172.30.64.1', '', 9, b'0', 0, 'apollo', '2024-05-28 17:22:02', 'apollo', '2024-05-28 17:22:02');
INSERT INTO `item` VALUES (96, 2, 'Service.Code', 0, 'GateWayService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:22:17', 'apollo', '2024-05-29 08:22:17');
INSERT INTO `item` VALUES (97, 3, 'Service.Code', 0, 'AuthService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:22:39', 'apollo', '2024-05-29 08:22:39');
INSERT INTO `item` VALUES (98, 4, 'Service.Code', 0, 'AdminService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:24:09', 'apollo', '2024-05-29 08:24:09');
INSERT INTO `item` VALUES (99, 5, 'Service.Code', 0, 'BaseService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:24:44', 'apollo', '2024-05-29 08:24:44');
INSERT INTO `item` VALUES (100, 6, 'Service.Code', 0, 'BackService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:24:59', 'apollo', '2024-05-29 08:24:59');
INSERT INTO `item` VALUES (101, 7, 'Service.Code', 0, 'CodeService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:25:13', 'apollo', '2024-05-29 08:25:13');
INSERT INTO `item` VALUES (102, 8, 'Service.Code', 0, 'TaskService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:25:34', 'apollo', '2024-05-29 08:25:34');
INSERT INTO `item` VALUES (103, 9, 'Service.Code', 0, 'ERPService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:25:49', 'apollo', '2024-05-29 08:25:49');
INSERT INTO `item` VALUES (104, 10, 'Service.Code', 0, 'OAService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:26:07', 'apollo', '2024-05-29 08:26:07');
INSERT INTO `item` VALUES (105, 11, 'Service.Code', 0, 'HRService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:26:21', 'apollo', '2024-05-29 08:26:21');
INSERT INTO `item` VALUES (106, 12, 'Service.Code', 0, 'PLMService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:26:49', 'apollo', '2024-05-29 08:26:49');
INSERT INTO `item` VALUES (107, 13, 'Service.Code', 0, 'KMSService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:27:03', 'apollo', '2024-05-29 08:27:03');
INSERT INTO `item` VALUES (108, 14, 'Service.Code', 0, 'CRMService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:27:20', 'apollo', '2024-05-29 08:27:20');
INSERT INTO `item` VALUES (109, 15, 'Service.Code', 0, 'SCMService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:27:40', 'apollo', '2024-05-29 08:27:40');
INSERT INTO `item` VALUES (110, 16, 'Service.Code', 0, 'ISMSService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:27:56', 'apollo', '2024-05-29 08:27:56');
INSERT INTO `item` VALUES (111, 17, 'Service.Code', 0, 'BIService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:28:14', 'apollo', '2024-05-29 08:28:14');
INSERT INTO `item` VALUES (112, 18, 'Service.Code', 0, 'AIService', '', 6, b'0', 0, 'apollo', '2024-05-29 08:28:30', 'apollo', '2024-05-29 08:28:30');

-- ----------------------------
-- Table structure for namespace
-- ----------------------------
DROP TABLE IF EXISTS `namespace`;
CREATE TABLE `namespace`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Cluster Name',
  `NamespaceName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'Namespace Name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_AppId_ClusterName_NamespaceName_DeletedAt`(`AppId` ASC, `ClusterName`(191) ASC, `NamespaceName`(191) ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_NamespaceName`(`NamespaceName`(191) ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '命名空间' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of namespace
-- ----------------------------
INSERT INTO `namespace` VALUES (1, 'EIS', 'default', 'application', b'0', 0, 'default', '2024-05-23 01:05:08', '', '2024-05-23 02:01:20');
INSERT INTO `namespace` VALUES (2, 'EIS', 'default', 'GateWayService', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `namespace` VALUES (3, 'EIS', 'default', 'AuthService', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `namespace` VALUES (4, 'EIS', 'default', 'AdminService', b'0', 0, 'apollo', '2024-05-23 10:09:46', 'apollo', '2024-05-23 10:09:46');
INSERT INTO `namespace` VALUES (5, 'EIS', 'default', 'BaseService', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `namespace` VALUES (6, 'EIS', 'default', 'BackService', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `namespace` VALUES (7, 'EIS', 'default', 'CodeService', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `namespace` VALUES (8, 'EIS', 'default', 'TaskService', b'0', 0, 'apollo', '2024-05-23 10:16:43', 'apollo', '2024-05-23 10:16:43');
INSERT INTO `namespace` VALUES (9, 'EIS', 'default', 'ERPSerivce', b'0', 0, 'apollo', '2024-05-23 10:19:19', 'apollo', '2024-05-23 10:19:19');
INSERT INTO `namespace` VALUES (10, 'EIS', 'default', 'OAService', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `namespace` VALUES (11, 'EIS', 'default', 'HRService', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `namespace` VALUES (12, 'EIS', 'default', 'PLMService', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `namespace` VALUES (13, 'EIS', 'default', 'KMSService', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `namespace` VALUES (14, 'EIS', 'default', 'CRMService', b'0', 0, 'apollo', '2024-05-23 10:22:58', 'apollo', '2024-05-23 10:22:58');
INSERT INTO `namespace` VALUES (15, 'EIS', 'default', 'SCMService', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `namespace` VALUES (16, 'EIS', 'default', 'ISMSService', b'0', 0, 'apollo', '2024-05-23 10:25:13', 'apollo', '2024-05-23 10:25:13');
INSERT INTO `namespace` VALUES (17, 'EIS', 'default', 'BIService', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `namespace` VALUES (18, 'EIS', 'default', 'AIService', b'0', 0, 'apollo', '2024-05-23 10:26:26', 'apollo', '2024-05-23 10:26:26');

-- ----------------------------
-- Table structure for namespacelock
-- ----------------------------
DROP TABLE IF EXISTS `namespacelock`;
CREATE TABLE `namespacelock`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `NamespaceId` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '集群NamespaceId',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `IsDeleted` bit(1) NULL DEFAULT b'0' COMMENT '软删除',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_NamespaceId_DeletedAt`(`NamespaceId` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'namespace的编辑锁' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of namespacelock
-- ----------------------------

-- ----------------------------
-- Table structure for release
-- ----------------------------
DROP TABLE IF EXISTS `release`;
CREATE TABLE `release`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `ReleaseKey` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '发布的Key',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '发布名字',
  `Comment` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发布说明',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `NamespaceName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `Configurations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发布配置',
  `IsAbandoned` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否废弃',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_ReleaseKey_DeletedAt`(`ReleaseKey` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `AppId_ClusterName_GroupName`(`AppId` ASC, `ClusterName`(191) ASC, `NamespaceName`(191) ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '发布' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of release
-- ----------------------------
INSERT INTO `release` VALUES (2, '20240528140624-27fd2ab79cef835c', '20240528140621-release', '', 'EIS', 'default', 'application', '{\"Swagger.Directory\":\"E:\\\\01Kesiau\\\\EIS\\\\.swagger\",\"DataBase.postgresSql\":\"Host\\u003d101.126.86.21;Port\\u003d5432;Database\\u003deis.base;Username\\u003dpostgres;Password\\u003dadmin@123;\",\"IdentityServer.Url\":\"http://localhost:5001\",\"Exceptionless.ServerUrl\":\"http://101.126.86.21:4000\",\"Exceptionless.ApiKey\":\"DVm5PVyjyoFKoOknhH4SFJOUXzWCKAXjOrsudCiU\",\"Consul.IP\":\"localhost\",\"Consul.Port\":\"8500\"}', b'0', b'0', 0, 'apollo', '2024-05-28 14:06:25', 'apollo', '2024-05-28 14:06:25');
INSERT INTO `release` VALUES (3, '20240528140630-0ebe2ab79cef835d', '20240528140628-release', '', 'EIS', 'default', 'GateWayService', '{\"Service.Name\":\"网关服务\",\"Service.Version\":\"1.0.0\",\"Service.HttpsMetadata\":\"http\",\"Service.IP\":\"localhost\",\"Service.Port\":\"5000\"}', b'0', b'0', 0, 'apollo', '2024-05-28 14:06:31', 'apollo', '2024-05-28 14:06:31');
INSERT INTO `release` VALUES (4, '20240528141312-27fd2ab79cef835e', '20240528141310-release', '', 'EIS', 'default', 'application', '{\"Swagger.Directory\":\"E:\\\\01Kesiau\\\\EIS\\\\.swagger\",\"DataBase.postgresSql\":\"Host\\u003d101.126.86.21;Port\\u003d5432;Database\\u003deis.base;Username\\u003dpostgres;Password\\u003dadmin@123;\",\"IdentityServer.Url\":\"http://localhost:5001\",\"Exceptionless.ServerUrl\":\"http://101.126.86.21:4000\",\"Exceptionless.ApiKey\":\"DVm5PVyjyoFKoOknhH4SFJOUXzWCKAXjOrsudCiU\",\"Consul.IP\":\"172.30.73.49\",\"Consul.Port\":\"8500\"}', b'0', b'0', 0, 'apollo', '2024-05-28 14:13:12', 'apollo', '2024-05-28 14:13:12');
INSERT INTO `release` VALUES (5, '20240528170710-27fda7b11b12464c', '20240528170708-release', '', 'EIS', 'default', 'application', '{\"Swagger.Directory\":\"E:\\\\01Kesiau\\\\EIS\\\\.swagger\",\"DataBase.postgresSql\":\"Host\\u003d101.126.86.21;Port\\u003d5432;Database\\u003deis.base;Username\\u003dpostgres;Password\\u003dadmin@123;\",\"IdentityServer.Url\":\"http://localhost:5001\",\"Exceptionless.ServerUrl\":\"http://101.126.86.21:4000\",\"Exceptionless.ApiKey\":\"DVm5PVyjyoFKoOknhH4SFJOUXzWCKAXjOrsudCiU\",\"Consul.IP\":\"172.30.73.49\",\"Consul.Port\":\"8500\",\"Listen.IP\":\"0.0.0.0\"}', b'0', b'0', 0, 'apollo', '2024-05-28 17:07:10', 'apollo', '2024-05-28 17:07:10');
INSERT INTO `release` VALUES (6, '20240528172501-27fd30c49ef22cef', '20240528172459-release', '', 'EIS', 'default', 'application', '{\"Swagger.Directory\":\"E:\\\\01Kesiau\\\\EIS\\\\.swagger\",\"DataBase.postgresSql\":\"Host\\u003d101.126.86.21;Port\\u003d5432;Database\\u003deis.base;Username\\u003dpostgres;Password\\u003dadmin@123;\",\"IdentityServer.Url\":\"http://localhost:5001\",\"Exceptionless.ServerUrl\":\"http://101.126.86.21:4000\",\"Exceptionless.ApiKey\":\"DVm5PVyjyoFKoOknhH4SFJOUXzWCKAXjOrsudCiU\",\"Consul.IP\":\"172.30.73.49\",\"Consul.Port\":\"8500\",\"Listen.IP\":\"0.0.0.0\",\"HealthCheck.IP\":\"172.30.64.1\"}', b'0', b'0', 0, 'apollo', '2024-05-28 17:25:01', 'apollo', '2024-05-28 17:25:01');
INSERT INTO `release` VALUES (7, '20240529082221-0ebe30c49efb92b1', '20240529082219-release', '', 'EIS', 'default', 'GateWayService', '{\"Service.Name\":\"网关服务\",\"Service.Version\":\"1.0.0\",\"Service.HttpsMetadata\":\"http\",\"Service.IP\":\"localhost\",\"Service.Port\":\"5000\",\"Service.Code\":\"GateWayService\"}', b'0', b'0', 0, 'apollo', '2024-05-29 08:22:21', 'apollo', '2024-05-29 08:22:21');
INSERT INTO `release` VALUES (8, '20240529082335-1e7a30c49efb92b2', '20240529082333-release', '', 'EIS', 'default', 'AuthService', '{\"Service.Name\":\"鉴权服务\",\"Service.Version\":\"1.0.0\",\"Service.HttpsMetadata\":\"http\",\"Service.IP\":\"localhost\",\"Service.Port\":\"5001\",\"Service.Code\":\"AuthService\"}', b'0', b'0', 0, 'apollo', '2024-05-29 08:23:36', 'apollo', '2024-05-29 08:23:36');

-- ----------------------------
-- Table structure for releasehistory
-- ----------------------------
DROP TABLE IF EXISTS `releasehistory`;
CREATE TABLE `releasehistory`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `ClusterName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'ClusterName',
  `NamespaceName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'namespaceName',
  `BranchName` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '发布分支名',
  `ReleaseId` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联的Release Id',
  `PreviousReleaseId` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '前一次发布的ReleaseId',
  `Operation` tinyint UNSIGNED NOT NULL DEFAULT 0 COMMENT '发布类型，0: 普通发布，1: 回滚，2: 灰度发布，3: 灰度规则更新，4: 灰度合并回主分支发布，5: 主分支发布灰度自动发布，6: 主分支回滚灰度自动发布，7: 放弃灰度',
  `OperationContext` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '发布上下文信息',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_Namespace`(`AppId` ASC, `ClusterName` ASC, `NamespaceName` ASC, `BranchName` ASC) USING BTREE,
  INDEX `IX_ReleaseId`(`ReleaseId` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_PreviousReleaseId`(`PreviousReleaseId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '发布历史' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of releasehistory
-- ----------------------------
INSERT INTO `releasehistory` VALUES (2, 'EIS', 'default', 'application', 'default', 2, 0, 0, '{\"isEmergencyPublish\":false}', b'0', 0, 'apollo', '2024-05-28 14:06:25', 'apollo', '2024-05-28 14:06:25');
INSERT INTO `releasehistory` VALUES (3, 'EIS', 'default', 'GateWayService', 'default', 3, 0, 0, '{\"isEmergencyPublish\":false}', b'0', 0, 'apollo', '2024-05-28 14:06:31', 'apollo', '2024-05-28 14:06:31');
INSERT INTO `releasehistory` VALUES (4, 'EIS', 'default', 'application', 'default', 4, 2, 0, '{\"isEmergencyPublish\":false}', b'0', 0, 'apollo', '2024-05-28 14:13:12', 'apollo', '2024-05-28 14:13:12');
INSERT INTO `releasehistory` VALUES (5, 'EIS', 'default', 'application', 'default', 5, 4, 0, '{\"isEmergencyPublish\":false}', b'0', 0, 'apollo', '2024-05-28 17:07:10', 'apollo', '2024-05-28 17:07:10');
INSERT INTO `releasehistory` VALUES (6, 'EIS', 'default', 'application', 'default', 6, 5, 0, '{\"isEmergencyPublish\":false}', b'0', 0, 'apollo', '2024-05-28 17:25:01', 'apollo', '2024-05-28 17:25:01');
INSERT INTO `releasehistory` VALUES (7, 'EIS', 'default', 'GateWayService', 'default', 7, 3, 0, '{\"isEmergencyPublish\":false}', b'0', 0, 'apollo', '2024-05-29 08:22:21', 'apollo', '2024-05-29 08:22:21');
INSERT INTO `releasehistory` VALUES (8, 'EIS', 'default', 'AuthService', 'default', 8, 0, 0, '{\"isEmergencyPublish\":false}', b'0', 0, 'apollo', '2024-05-29 08:23:36', 'apollo', '2024-05-29 08:23:36');

-- ----------------------------
-- Table structure for releasemessage
-- ----------------------------
DROP TABLE IF EXISTS `releasemessage`;
CREATE TABLE `releasemessage`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Message` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '发布的消息内容',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_Message`(`Message`(191) ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '发布消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of releasemessage
-- ----------------------------
INSERT INTO `releasemessage` VALUES (6, 'EIS+default+application', '2024-05-28 17:25:01');
INSERT INTO `releasemessage` VALUES (7, 'EIS+default+GateWayService', '2024-05-29 08:22:21');
INSERT INTO `releasemessage` VALUES (8, 'EIS+default+AuthService', '2024-05-29 08:23:36');

-- ----------------------------
-- Table structure for serverconfig
-- ----------------------------
DROP TABLE IF EXISTS `serverconfig`;
CREATE TABLE `serverconfig`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Cluster` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '配置对应的集群，default为不针对特定的集群',
  `Value` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '配置项值',
  `Comment` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_Key_Cluster_DeletedAt`(`Key` ASC, `Cluster` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '配置服务自身配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of serverconfig
-- ----------------------------
INSERT INTO `serverconfig` VALUES (1, 'eureka.service.url', 'default', 'http://172.30.73.49:8080/eureka/', 'Eureka服务Url，多个service以英文逗号分隔', b'0', 0, 'default', '2024-05-23 01:05:07', '', '2024-05-28 05:53:04');
INSERT INTO `serverconfig` VALUES (2, 'namespace.lock.switch', 'default', 'false', '一次发布只能有一个人修改开关', b'0', 0, 'default', '2024-05-23 01:05:07', '', '2024-05-23 01:05:07');
INSERT INTO `serverconfig` VALUES (3, 'item.key.length.limit', 'default', '128', 'item key 最大长度限制', b'0', 0, 'default', '2024-05-23 01:05:07', '', '2024-05-23 01:05:07');
INSERT INTO `serverconfig` VALUES (4, 'item.value.length.limit', 'default', '20000', 'item value最大长度限制', b'0', 0, 'default', '2024-05-23 01:05:07', '', '2024-05-23 01:05:07');
INSERT INTO `serverconfig` VALUES (5, 'config-service.cache.enabled', 'default', 'false', 'ConfigService是否开启缓存，开启后能提高性能，但是会增大内存消耗！', b'0', 0, 'default', '2024-05-23 01:05:07', '', '2024-05-23 01:05:07');

-- ----------------------------
-- Table structure for serviceregistry
-- ----------------------------
DROP TABLE IF EXISTS `serviceregistry`;
CREATE TABLE `serviceregistry`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ServiceName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务名',
  `Uri` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '服务地址',
  `Cluster` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '集群，可以用来标识apollo.cluster或者网络分区',
  `Metadata` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '{}' COMMENT '元数据，key value结构的json object，为了方面后面扩展功能而不需要修改表结构',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `IX_UNIQUE_KEY`(`ServiceName` ASC, `Uri` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '注册中心' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of serviceregistry
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
