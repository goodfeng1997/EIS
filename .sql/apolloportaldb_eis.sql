/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : apolloportaldb

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 29/05/2024 08:29:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
INSERT INTO `app` VALUES (1, 'EIS', '企业信息一体化平台', 'EIS', '企业信息一体化平台部', 'apollo', 'apollo@acme.com', b'0', 0, 'default', '2024-05-23 01:05:36', 'apollo', '2024-05-23 10:06:26');

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
INSERT INTO `appnamespace` VALUES (1, 'application', 'EIS', 'properties', b'0', 'default app namespace', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:03:11');
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
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审计日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auditlog
-- ----------------------------
INSERT INTO `auditlog` VALUES (1, 'd4720d817eb94815937b98a4307d841a', '12c0eb320b574ebdb8e66b4332907e33', NULL, NULL, 'apollo', 'UPDATE', 'App.update', 'no description', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');
INSERT INTO `auditlog` VALUES (2, 'd4720d817eb94815937b98a4307d841a', '39be5ed02496431f99d226443d16737d', '12c0eb320b574ebdb8e66b4332907e33', NULL, 'apollo', 'UPDATE', 'App.update', 'no description', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');
INSERT INTO `auditlog` VALUES (3, 'd4720d817eb94815937b98a4307d841a', 'e281187e88cb4b158ce879806e5df483', '12c0eb320b574ebdb8e66b4332907e33', '39be5ed02496431f99d226443d16737d', 'apollo', 'RPC', 'App.updateInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');
INSERT INTO `auditlog` VALUES (4, 'e3ac91e073f747f18848d4dbc5052f3a', '22edeb783f6a40c0b974a99b595bb3ea', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlog` VALUES (5, 'e3ac91e073f747f18848d4dbc5052f3a', 'a0ef36768e2243629163db9a73761864', '22edeb783f6a40c0b974a99b595bb3ea', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlog` VALUES (6, 'e3ac91e073f747f18848d4dbc5052f3a', 'f811d42baca049f3872e3772dfbaed51', '22edeb783f6a40c0b974a99b595bb3ea', 'a0ef36768e2243629163db9a73761864', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlog` VALUES (7, 'e3ac91e073f747f18848d4dbc5052f3a', 'c2983bba170f4f2bab414bc69d73eb05', '22edeb783f6a40c0b974a99b595bb3ea', 'f811d42baca049f3872e3772dfbaed51', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlog` VALUES (8, 'e3ac91e073f747f18848d4dbc5052f3a', 'bf2b5a70235b4e37839b1cd2c1ba35d9', '22edeb783f6a40c0b974a99b595bb3ea', 'c2983bba170f4f2bab414bc69d73eb05', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlog` VALUES (9, '6e00528de7d440a195169f495462a142', 'f8d87daa9bb64245bd16a30a51333b27', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlog` VALUES (10, '6e00528de7d440a195169f495462a142', 'd4f59f7c34394cb38396b5d793d49004', 'f8d87daa9bb64245bd16a30a51333b27', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlog` VALUES (11, '6e00528de7d440a195169f495462a142', '80245d7e049c422285344c495f0203ca', 'f8d87daa9bb64245bd16a30a51333b27', 'd4f59f7c34394cb38396b5d793d49004', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlog` VALUES (12, '6e00528de7d440a195169f495462a142', 'f99a39a8869d492db2106a29f64968e8', 'f8d87daa9bb64245bd16a30a51333b27', '80245d7e049c422285344c495f0203ca', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlog` VALUES (13, '6e00528de7d440a195169f495462a142', '17140bee0d4342cab36ec58feb407495', 'f8d87daa9bb64245bd16a30a51333b27', 'f99a39a8869d492db2106a29f64968e8', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlog` VALUES (14, 'be269db4fffe42d58be984a3691b51aa', 'f3693853d0a34c02a804f85286ebf621', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlog` VALUES (15, 'be269db4fffe42d58be984a3691b51aa', '9a435d3dbd464a339c551d04f2299e90', 'f3693853d0a34c02a804f85286ebf621', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlog` VALUES (16, 'be269db4fffe42d58be984a3691b51aa', '85a3ab7bb76c4d629b36693bfea6c224', 'f3693853d0a34c02a804f85286ebf621', '9a435d3dbd464a339c551d04f2299e90', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlog` VALUES (17, 'be269db4fffe42d58be984a3691b51aa', 'bf948e6dc46949bbbe43d381a59bc24f', 'f3693853d0a34c02a804f85286ebf621', '85a3ab7bb76c4d629b36693bfea6c224', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlog` VALUES (18, 'be269db4fffe42d58be984a3691b51aa', 'b3e090abab414d80a2e312209d37b335', 'f3693853d0a34c02a804f85286ebf621', 'bf948e6dc46949bbbe43d381a59bc24f', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:09:46', NULL, '2024-05-23 10:09:46');
INSERT INTO `auditlog` VALUES (19, 'a300860b0f8046fa97a7df4385485437', '3fcacbf5d4ba42e8b21803d4f424ad02', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlog` VALUES (20, 'a300860b0f8046fa97a7df4385485437', '79c6c5f5403545a79d74c78facae1a8d', '3fcacbf5d4ba42e8b21803d4f424ad02', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlog` VALUES (21, 'a300860b0f8046fa97a7df4385485437', '485e045277aa4da2b8a32d5187e74dc0', '3fcacbf5d4ba42e8b21803d4f424ad02', '79c6c5f5403545a79d74c78facae1a8d', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlog` VALUES (22, 'a300860b0f8046fa97a7df4385485437', '9954d5cc663d4203a82323f6ce798678', '3fcacbf5d4ba42e8b21803d4f424ad02', '485e045277aa4da2b8a32d5187e74dc0', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlog` VALUES (23, 'a300860b0f8046fa97a7df4385485437', 'e4c1f910fae84e019d0e5bd98a4c724c', '3fcacbf5d4ba42e8b21803d4f424ad02', '9954d5cc663d4203a82323f6ce798678', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlog` VALUES (24, '0262291cf8a04995bc41394a079106cf', 'abbc57e11c844909b7a9313fbe847746', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlog` VALUES (25, '0262291cf8a04995bc41394a079106cf', '1a912b4a77414d98af2d15434f3a1f4f', 'abbc57e11c844909b7a9313fbe847746', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlog` VALUES (26, '0262291cf8a04995bc41394a079106cf', '237355ff993941ca89382360fde54fd9', 'abbc57e11c844909b7a9313fbe847746', '1a912b4a77414d98af2d15434f3a1f4f', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlog` VALUES (27, '0262291cf8a04995bc41394a079106cf', 'ea702237d8e847b1829bb6c1923fb521', 'abbc57e11c844909b7a9313fbe847746', '237355ff993941ca89382360fde54fd9', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlog` VALUES (28, '0262291cf8a04995bc41394a079106cf', '8324db7a0d13477484373db823fdff45', 'abbc57e11c844909b7a9313fbe847746', 'ea702237d8e847b1829bb6c1923fb521', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlog` VALUES (29, '5b5c1132260446cd96278df2e9530911', '812da795a8a540ab9f9fc83dd5ec5c2e', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:16:19', NULL, '2024-05-23 10:16:19');
INSERT INTO `auditlog` VALUES (30, '5b5c1132260446cd96278df2e9530911', '2137322b6f344f5fb845571411595945', '812da795a8a540ab9f9fc83dd5ec5c2e', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:16:19', NULL, '2024-05-23 10:16:19');
INSERT INTO `auditlog` VALUES (31, '5b5c1132260446cd96278df2e9530911', 'c2d4cd490a0a48229c5cfb466df3cac5', '812da795a8a540ab9f9fc83dd5ec5c2e', '2137322b6f344f5fb845571411595945', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlog` VALUES (32, '5b5c1132260446cd96278df2e9530911', 'a7edb8cde18a491993eb321cde7e1ff5', '812da795a8a540ab9f9fc83dd5ec5c2e', 'c2d4cd490a0a48229c5cfb466df3cac5', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlog` VALUES (33, '5b5c1132260446cd96278df2e9530911', 'bbd575d8b9504e3ebfd0c24bfb93b86d', '812da795a8a540ab9f9fc83dd5ec5c2e', 'a7edb8cde18a491993eb321cde7e1ff5', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlog` VALUES (34, '983c9d71e2e345a08cd49b31638f47bd', 'be08a130cc3c4cc597fd3fa98e060dcb', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlog` VALUES (35, '983c9d71e2e345a08cd49b31638f47bd', '95e4f39e7deb43148d87500516e2a9ae', 'be08a130cc3c4cc597fd3fa98e060dcb', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlog` VALUES (36, '983c9d71e2e345a08cd49b31638f47bd', '5856db14f4e64706b7e9543f131693b3', 'be08a130cc3c4cc597fd3fa98e060dcb', '95e4f39e7deb43148d87500516e2a9ae', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `auditlog` VALUES (37, '983c9d71e2e345a08cd49b31638f47bd', '121b4cf13dd0455b8f03f03d7f22751b', 'be08a130cc3c4cc597fd3fa98e060dcb', '5856db14f4e64706b7e9543f131693b3', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `auditlog` VALUES (38, '983c9d71e2e345a08cd49b31638f47bd', '771d281a3a6e4153ab58da4367f3d2a7', 'be08a130cc3c4cc597fd3fa98e060dcb', '121b4cf13dd0455b8f03f03d7f22751b', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `auditlog` VALUES (39, 'd19aa5ecf3b143458970f90c99e91e03', 'a9867988e78049a9a11ad90cedef2a7f', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlog` VALUES (40, 'd19aa5ecf3b143458970f90c99e91e03', '46f14663ce2047f494c84505619decaa', 'a9867988e78049a9a11ad90cedef2a7f', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlog` VALUES (41, 'd19aa5ecf3b143458970f90c99e91e03', '2930122f99194bc78ab278440f7a3f97', 'a9867988e78049a9a11ad90cedef2a7f', '46f14663ce2047f494c84505619decaa', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `auditlog` VALUES (42, 'd19aa5ecf3b143458970f90c99e91e03', '4cb06c3b6f7248e383d572d5757ab5ff', 'a9867988e78049a9a11ad90cedef2a7f', '2930122f99194bc78ab278440f7a3f97', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `auditlog` VALUES (43, 'd19aa5ecf3b143458970f90c99e91e03', '623a1679732a4826b1e0004e42dfba0e', 'a9867988e78049a9a11ad90cedef2a7f', '4cb06c3b6f7248e383d572d5757ab5ff', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `auditlog` VALUES (44, '72e3890f86b64e5db5292c3b360e70e8', 'fe1dc1cc88d54460bc64df2542d4fdbc', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:20:06', NULL, '2024-05-23 10:20:06');
INSERT INTO `auditlog` VALUES (45, '72e3890f86b64e5db5292c3b360e70e8', '29c18c509fe04080b5920382e921e70c', 'fe1dc1cc88d54460bc64df2542d4fdbc', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:20:06', NULL, '2024-05-23 10:20:06');
INSERT INTO `auditlog` VALUES (46, '72e3890f86b64e5db5292c3b360e70e8', '0d04c17a565b4695a95ce342c7c04e8c', 'fe1dc1cc88d54460bc64df2542d4fdbc', '29c18c509fe04080b5920382e921e70c', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlog` VALUES (47, '72e3890f86b64e5db5292c3b360e70e8', '10cb7f4bac3042c287ee1ae19eab7cd4', 'fe1dc1cc88d54460bc64df2542d4fdbc', '0d04c17a565b4695a95ce342c7c04e8c', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlog` VALUES (48, '72e3890f86b64e5db5292c3b360e70e8', '4c1551b60d864fbc8edad023d1ac3f84', 'fe1dc1cc88d54460bc64df2542d4fdbc', '10cb7f4bac3042c287ee1ae19eab7cd4', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlog` VALUES (49, '5fc505d92694435a9c388166f014695c', 'c70470849b7f46ee8dce0263ff1b2163', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlog` VALUES (50, '5fc505d92694435a9c388166f014695c', '8cc972ddce704dc38d5fc0e50884f838', 'c70470849b7f46ee8dce0263ff1b2163', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlog` VALUES (51, '5fc505d92694435a9c388166f014695c', '0df2a720f56046738bdbeedc901d0e18', 'c70470849b7f46ee8dce0263ff1b2163', '8cc972ddce704dc38d5fc0e50884f838', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlog` VALUES (52, '5fc505d92694435a9c388166f014695c', '536c0c27460948d189b0d3df53e36f01', 'c70470849b7f46ee8dce0263ff1b2163', '0df2a720f56046738bdbeedc901d0e18', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlog` VALUES (53, '5fc505d92694435a9c388166f014695c', '7db4a9172b3e4ab8b24ba5c377cef893', 'c70470849b7f46ee8dce0263ff1b2163', '536c0c27460948d189b0d3df53e36f01', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlog` VALUES (54, '6908e2827e2a4227903246de05f61c71', '09b888dace284b1c85a56c0374c4ea3b', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlog` VALUES (55, '6908e2827e2a4227903246de05f61c71', 'e56e2eeeedfa4508971477bd90257015', '09b888dace284b1c85a56c0374c4ea3b', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlog` VALUES (56, '6908e2827e2a4227903246de05f61c71', 'b291dc94b5fc485c8be4e7106f989ea6', '09b888dace284b1c85a56c0374c4ea3b', 'e56e2eeeedfa4508971477bd90257015', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlog` VALUES (57, '6908e2827e2a4227903246de05f61c71', '450c113142754784a99941e9db46a952', '09b888dace284b1c85a56c0374c4ea3b', 'b291dc94b5fc485c8be4e7106f989ea6', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlog` VALUES (58, '6908e2827e2a4227903246de05f61c71', '589e781caa3746ff9d95adb3a157e540', '09b888dace284b1c85a56c0374c4ea3b', '450c113142754784a99941e9db46a952', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlog` VALUES (59, 'f1981a26214c4368a64c14028dd6525e', '2b8d6dccb0874b27bde88ecd4237feb1', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlog` VALUES (60, 'f1981a26214c4368a64c14028dd6525e', '0c0044c317a740628cf9faa4604ac952', '2b8d6dccb0874b27bde88ecd4237feb1', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlog` VALUES (61, 'f1981a26214c4368a64c14028dd6525e', '1bb5d142bcb24f8289bc07417b1a2d1c', '2b8d6dccb0874b27bde88ecd4237feb1', '0c0044c317a740628cf9faa4604ac952', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlog` VALUES (62, 'f1981a26214c4368a64c14028dd6525e', 'd3a7b0d066354c1eb30e6a26c1f69c65', '2b8d6dccb0874b27bde88ecd4237feb1', '1bb5d142bcb24f8289bc07417b1a2d1c', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlog` VALUES (63, 'f1981a26214c4368a64c14028dd6525e', '41045ffd16a44c688d07a7d3c4c22432', '2b8d6dccb0874b27bde88ecd4237feb1', 'd3a7b0d066354c1eb30e6a26c1f69c65', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlog` VALUES (64, 'f42fd6efb6864ffd94ae25e897f76895', '26831e6991ad49f481b530ff7fbd3d29', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlog` VALUES (65, 'f42fd6efb6864ffd94ae25e897f76895', '03cd93e3bb4d48638ab62ba7ddcf8daa', '26831e6991ad49f481b530ff7fbd3d29', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlog` VALUES (66, 'f42fd6efb6864ffd94ae25e897f76895', 'd165dc2bebce46fcb017bde127a025d6', '26831e6991ad49f481b530ff7fbd3d29', '03cd93e3bb4d48638ab62ba7ddcf8daa', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlog` VALUES (67, 'f42fd6efb6864ffd94ae25e897f76895', '992314248bf8428884d103cab7226884', '26831e6991ad49f481b530ff7fbd3d29', 'd165dc2bebce46fcb017bde127a025d6', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `auditlog` VALUES (68, 'f42fd6efb6864ffd94ae25e897f76895', '0679dc09d626489796be49939fab1a05', '26831e6991ad49f481b530ff7fbd3d29', '992314248bf8428884d103cab7226884', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `auditlog` VALUES (69, '15ea4617889b4066a66a10f5a931778f', 'b873efbb23ef4e848cc27b8cb4cd1eea', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlog` VALUES (70, '15ea4617889b4066a66a10f5a931778f', 'a1082d8c289e464d93865c56c9d4f940', 'b873efbb23ef4e848cc27b8cb4cd1eea', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlog` VALUES (71, '15ea4617889b4066a66a10f5a931778f', 'effbcede88a64489801ec79f43ba8556', 'b873efbb23ef4e848cc27b8cb4cd1eea', 'a1082d8c289e464d93865c56c9d4f940', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlog` VALUES (72, '15ea4617889b4066a66a10f5a931778f', 'd864d25888ff46dd9cda9d61958d81eb', 'b873efbb23ef4e848cc27b8cb4cd1eea', 'effbcede88a64489801ec79f43ba8556', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlog` VALUES (73, '15ea4617889b4066a66a10f5a931778f', '01f351767d3d4fd596b2e4d7254b9ecc', 'b873efbb23ef4e848cc27b8cb4cd1eea', 'd864d25888ff46dd9cda9d61958d81eb', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlog` VALUES (74, '6e5a837577ef4e929312e444c1f546c4', '21e0fbb928c747fa93f84bd6d7c1757a', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlog` VALUES (75, '6e5a837577ef4e929312e444c1f546c4', 'd5a66b161e0c48d68ff82c3942f9c87d', '21e0fbb928c747fa93f84bd6d7c1757a', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlog` VALUES (76, '6e5a837577ef4e929312e444c1f546c4', 'b1ec692994024a43890e0f84c1952a07', '21e0fbb928c747fa93f84bd6d7c1757a', 'd5a66b161e0c48d68ff82c3942f9c87d', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlog` VALUES (77, '6e5a837577ef4e929312e444c1f546c4', '03e03491110747cc8622d9387262936a', '21e0fbb928c747fa93f84bd6d7c1757a', 'b1ec692994024a43890e0f84c1952a07', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlog` VALUES (78, '6e5a837577ef4e929312e444c1f546c4', 'd68d9be1bce8434eaa237966226608e9', '21e0fbb928c747fa93f84bd6d7c1757a', '03e03491110747cc8622d9387262936a', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlog` VALUES (79, 'b619c3adf8d546bbadc71c1ffcd5b364', 'b2e23114eba940a7bd990e6d9f461ec7', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlog` VALUES (80, 'b619c3adf8d546bbadc71c1ffcd5b364', '9edbc45f40f84daa9366680f9e9e53d4', 'b2e23114eba940a7bd990e6d9f461ec7', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlog` VALUES (81, 'b619c3adf8d546bbadc71c1ffcd5b364', '976f943ac6e6458687c149eec79133a5', 'b2e23114eba940a7bd990e6d9f461ec7', '9edbc45f40f84daa9366680f9e9e53d4', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlog` VALUES (82, 'b619c3adf8d546bbadc71c1ffcd5b364', '54fc46321fd94dc0b1dcc803b0c22fcf', 'b2e23114eba940a7bd990e6d9f461ec7', '976f943ac6e6458687c149eec79133a5', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlog` VALUES (83, 'b619c3adf8d546bbadc71c1ffcd5b364', '4ce55dc71d5b4ddca73b62f243cbeffd', 'b2e23114eba940a7bd990e6d9f461ec7', '54fc46321fd94dc0b1dcc803b0c22fcf', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlog` VALUES (84, '349beabd234d4262b6148d89f99a2d87', '45cb5ff0b2cb4849a6e9114cb87840a0', NULL, NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'no description', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlog` VALUES (85, '349beabd234d4262b6148d89f99a2d87', 'ef7f67eff753472ab9742af51a57e357', '45cb5ff0b2cb4849a6e9114cb87840a0', NULL, 'apollo', 'CREATE', 'AppNamespace.create', 'createAppNamespaceInLocal', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlog` VALUES (86, '349beabd234d4262b6148d89f99a2d87', '42d1e8721c5b44889fe0ac98dc6de862', '45cb5ff0b2cb4849a6e9114cb87840a0', 'ef7f67eff753472ab9742af51a57e357', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');
INSERT INTO `auditlog` VALUES (87, '349beabd234d4262b6148d89f99a2d87', '2307d398509f44a483fe6ecdb8c5e1d9', '45cb5ff0b2cb4849a6e9114cb87840a0', '42d1e8721c5b44889fe0ac98dc6de862', 'apollo', 'CREATE', 'Auth.assignRoleToUsers', 'no description', b'0', 0, NULL, '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');
INSERT INTO `auditlog` VALUES (88, '349beabd234d4262b6148d89f99a2d87', '353e5bd01bc54e29814a9fcd10261859', '45cb5ff0b2cb4849a6e9114cb87840a0', '2307d398509f44a483fe6ecdb8c5e1d9', 'apollo', 'RPC', 'AppNamespace.createInRemote', 'no description', b'0', 0, NULL, '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');

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
) ENGINE = InnoDB AUTO_INCREMENT = 207 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '审计日志数据变动表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of auditlogdatainfluence
-- ----------------------------
INSERT INTO `auditlogdatainfluence` VALUES (1, '39be5ed02496431f99d226443d16737d', '1', 'App', 'Name', NULL, '企业信息一体化平台', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');
INSERT INTO `auditlogdatainfluence` VALUES (2, '39be5ed02496431f99d226443d16737d', '1', 'App', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:06:26', NULL, '2024-05-23 10:06:26');
INSERT INTO `auditlogdatainfluence` VALUES (3, 'a0ef36768e2243629163db9a73761864', '2', 'AppNamespace', 'Name', NULL, 'GateWayService', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (4, 'a0ef36768e2243629163db9a73761864', '2', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (5, 'a0ef36768e2243629163db9a73761864', '2', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (6, 'a0ef36768e2243629163db9a73761864', '2', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (7, 'a0ef36768e2243629163db9a73761864', '4', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+GateWayService', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (8, 'a0ef36768e2243629163db9a73761864', '5', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+GateWayService', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (9, 'a0ef36768e2243629163db9a73761864', '6', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+GateWayService+DEV', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (10, 'a0ef36768e2243629163db9a73761864', '7', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+GateWayService+DEV', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (11, 'f811d42baca049f3872e3772dfbaed51', '4', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (12, 'f811d42baca049f3872e3772dfbaed51', '4', 'UserRole', 'RoleId', NULL, '4', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (13, 'c2983bba170f4f2bab414bc69d73eb05', '5', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (14, 'c2983bba170f4f2bab414bc69d73eb05', '5', 'UserRole', 'RoleId', NULL, '5', b'0', 0, NULL, '2024-05-23 10:08:29', NULL, '2024-05-23 10:08:29');
INSERT INTO `auditlogdatainfluence` VALUES (15, 'd4f59f7c34394cb38396b5d793d49004', '3', 'AppNamespace', 'Name', NULL, 'AuthService', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (16, 'd4f59f7c34394cb38396b5d793d49004', '3', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (17, 'd4f59f7c34394cb38396b5d793d49004', '3', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (18, 'd4f59f7c34394cb38396b5d793d49004', '3', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (19, 'd4f59f7c34394cb38396b5d793d49004', '8', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+AuthService', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (20, 'd4f59f7c34394cb38396b5d793d49004', '9', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+AuthService', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (21, 'd4f59f7c34394cb38396b5d793d49004', '10', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+AuthService+DEV', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (22, 'd4f59f7c34394cb38396b5d793d49004', '11', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+AuthService+DEV', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (23, '80245d7e049c422285344c495f0203ca', '6', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (24, '80245d7e049c422285344c495f0203ca', '6', 'UserRole', 'RoleId', NULL, '8', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (25, 'f99a39a8869d492db2106a29f64968e8', '7', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (26, 'f99a39a8869d492db2106a29f64968e8', '7', 'UserRole', 'RoleId', NULL, '9', b'0', 0, NULL, '2024-05-23 10:08:54', NULL, '2024-05-23 10:08:54');
INSERT INTO `auditlogdatainfluence` VALUES (27, '9a435d3dbd464a339c551d04f2299e90', '4', 'AppNamespace', 'Name', NULL, 'AdminService', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (28, '9a435d3dbd464a339c551d04f2299e90', '4', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (29, '9a435d3dbd464a339c551d04f2299e90', '4', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (30, '9a435d3dbd464a339c551d04f2299e90', '4', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (31, '9a435d3dbd464a339c551d04f2299e90', '12', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+AdminService', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (32, '9a435d3dbd464a339c551d04f2299e90', '13', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+AdminService', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (33, '9a435d3dbd464a339c551d04f2299e90', '14', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+AdminService+DEV', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (34, '9a435d3dbd464a339c551d04f2299e90', '15', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+AdminService+DEV', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (35, '85a3ab7bb76c4d629b36693bfea6c224', '8', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (36, '85a3ab7bb76c4d629b36693bfea6c224', '8', 'UserRole', 'RoleId', NULL, '12', b'0', 0, NULL, '2024-05-23 10:09:45', NULL, '2024-05-23 10:09:45');
INSERT INTO `auditlogdatainfluence` VALUES (37, 'bf948e6dc46949bbbe43d381a59bc24f', '9', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:09:46', NULL, '2024-05-23 10:09:46');
INSERT INTO `auditlogdatainfluence` VALUES (38, 'bf948e6dc46949bbbe43d381a59bc24f', '9', 'UserRole', 'RoleId', NULL, '13', b'0', 0, NULL, '2024-05-23 10:09:46', NULL, '2024-05-23 10:09:46');
INSERT INTO `auditlogdatainfluence` VALUES (39, '79c6c5f5403545a79d74c78facae1a8d', '5', 'AppNamespace', 'Name', NULL, 'BaseService', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (40, '79c6c5f5403545a79d74c78facae1a8d', '5', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (41, '79c6c5f5403545a79d74c78facae1a8d', '5', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (42, '79c6c5f5403545a79d74c78facae1a8d', '5', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (43, '79c6c5f5403545a79d74c78facae1a8d', '16', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+BaseService', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (44, '79c6c5f5403545a79d74c78facae1a8d', '17', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+BaseService', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (45, '79c6c5f5403545a79d74c78facae1a8d', '18', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+BaseService+DEV', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (46, '79c6c5f5403545a79d74c78facae1a8d', '19', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+BaseService+DEV', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (47, '485e045277aa4da2b8a32d5187e74dc0', '10', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (48, '485e045277aa4da2b8a32d5187e74dc0', '10', 'UserRole', 'RoleId', NULL, '16', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (49, '9954d5cc663d4203a82323f6ce798678', '11', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (50, '9954d5cc663d4203a82323f6ce798678', '11', 'UserRole', 'RoleId', NULL, '17', b'0', 0, NULL, '2024-05-23 10:10:13', NULL, '2024-05-23 10:10:13');
INSERT INTO `auditlogdatainfluence` VALUES (51, '1a912b4a77414d98af2d15434f3a1f4f', '6', 'AppNamespace', 'Name', NULL, 'BackService', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (52, '1a912b4a77414d98af2d15434f3a1f4f', '6', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (53, '1a912b4a77414d98af2d15434f3a1f4f', '6', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (54, '1a912b4a77414d98af2d15434f3a1f4f', '6', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (55, '1a912b4a77414d98af2d15434f3a1f4f', '20', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+BackService', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (56, '1a912b4a77414d98af2d15434f3a1f4f', '21', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+BackService', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (57, '1a912b4a77414d98af2d15434f3a1f4f', '22', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+BackService+DEV', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (58, '1a912b4a77414d98af2d15434f3a1f4f', '23', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+BackService+DEV', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (59, '237355ff993941ca89382360fde54fd9', '12', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (60, '237355ff993941ca89382360fde54fd9', '12', 'UserRole', 'RoleId', NULL, '20', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (61, 'ea702237d8e847b1829bb6c1923fb521', '13', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (62, 'ea702237d8e847b1829bb6c1923fb521', '13', 'UserRole', 'RoleId', NULL, '21', b'0', 0, NULL, '2024-05-23 10:10:34', NULL, '2024-05-23 10:10:34');
INSERT INTO `auditlogdatainfluence` VALUES (63, '2137322b6f344f5fb845571411595945', '7', 'AppNamespace', 'Name', NULL, 'CodeService', b'0', 0, NULL, '2024-05-23 10:16:19', NULL, '2024-05-23 10:16:19');
INSERT INTO `auditlogdatainfluence` VALUES (64, '2137322b6f344f5fb845571411595945', '7', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:16:19', NULL, '2024-05-23 10:16:19');
INSERT INTO `auditlogdatainfluence` VALUES (65, '2137322b6f344f5fb845571411595945', '7', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:16:19', NULL, '2024-05-23 10:16:19');
INSERT INTO `auditlogdatainfluence` VALUES (66, '2137322b6f344f5fb845571411595945', '7', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (67, '2137322b6f344f5fb845571411595945', '24', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+CodeService', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (68, '2137322b6f344f5fb845571411595945', '25', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+CodeService', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (69, '2137322b6f344f5fb845571411595945', '26', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+CodeService+DEV', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (70, '2137322b6f344f5fb845571411595945', '27', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+CodeService+DEV', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (71, 'c2d4cd490a0a48229c5cfb466df3cac5', '14', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (72, 'c2d4cd490a0a48229c5cfb466df3cac5', '14', 'UserRole', 'RoleId', NULL, '24', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (73, 'a7edb8cde18a491993eb321cde7e1ff5', '15', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (74, 'a7edb8cde18a491993eb321cde7e1ff5', '15', 'UserRole', 'RoleId', NULL, '25', b'0', 0, NULL, '2024-05-23 10:16:20', NULL, '2024-05-23 10:16:20');
INSERT INTO `auditlogdatainfluence` VALUES (75, '95e4f39e7deb43148d87500516e2a9ae', '8', 'AppNamespace', 'Name', NULL, 'TaskService', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (76, '95e4f39e7deb43148d87500516e2a9ae', '8', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (77, '95e4f39e7deb43148d87500516e2a9ae', '8', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (78, '95e4f39e7deb43148d87500516e2a9ae', '8', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (79, '95e4f39e7deb43148d87500516e2a9ae', '28', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+TaskService', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (80, '95e4f39e7deb43148d87500516e2a9ae', '29', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+TaskService', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (81, '95e4f39e7deb43148d87500516e2a9ae', '30', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+TaskService+DEV', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (82, '95e4f39e7deb43148d87500516e2a9ae', '31', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+TaskService+DEV', b'0', 0, NULL, '2024-05-23 10:16:42', NULL, '2024-05-23 10:16:42');
INSERT INTO `auditlogdatainfluence` VALUES (83, '5856db14f4e64706b7e9543f131693b3', '16', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `auditlogdatainfluence` VALUES (84, '5856db14f4e64706b7e9543f131693b3', '16', 'UserRole', 'RoleId', NULL, '28', b'0', 0, NULL, '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `auditlogdatainfluence` VALUES (85, '121b4cf13dd0455b8f03f03d7f22751b', '17', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `auditlogdatainfluence` VALUES (86, '121b4cf13dd0455b8f03f03d7f22751b', '17', 'UserRole', 'RoleId', NULL, '29', b'0', 0, NULL, '2024-05-23 10:16:43', NULL, '2024-05-23 10:16:43');
INSERT INTO `auditlogdatainfluence` VALUES (87, '46f14663ce2047f494c84505619decaa', '9', 'AppNamespace', 'Name', NULL, 'ERPSerivce', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (88, '46f14663ce2047f494c84505619decaa', '9', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (89, '46f14663ce2047f494c84505619decaa', '9', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (90, '46f14663ce2047f494c84505619decaa', '9', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (91, '46f14663ce2047f494c84505619decaa', '32', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+ERPSerivce', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (92, '46f14663ce2047f494c84505619decaa', '33', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+ERPSerivce', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (93, '46f14663ce2047f494c84505619decaa', '34', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+ERPSerivce+DEV', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (94, '46f14663ce2047f494c84505619decaa', '35', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+ERPSerivce+DEV', b'0', 0, NULL, '2024-05-23 10:19:18', NULL, '2024-05-23 10:19:18');
INSERT INTO `auditlogdatainfluence` VALUES (95, '2930122f99194bc78ab278440f7a3f97', '18', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `auditlogdatainfluence` VALUES (96, '2930122f99194bc78ab278440f7a3f97', '18', 'UserRole', 'RoleId', NULL, '32', b'0', 0, NULL, '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `auditlogdatainfluence` VALUES (97, '4cb06c3b6f7248e383d572d5757ab5ff', '19', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `auditlogdatainfluence` VALUES (98, '4cb06c3b6f7248e383d572d5757ab5ff', '19', 'UserRole', 'RoleId', NULL, '33', b'0', 0, NULL, '2024-05-23 10:19:19', NULL, '2024-05-23 10:19:19');
INSERT INTO `auditlogdatainfluence` VALUES (99, '29c18c509fe04080b5920382e921e70c', '10', 'AppNamespace', 'Name', NULL, 'OAService', b'0', 0, NULL, '2024-05-23 10:20:06', NULL, '2024-05-23 10:20:06');
INSERT INTO `auditlogdatainfluence` VALUES (100, '29c18c509fe04080b5920382e921e70c', '10', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:20:06', NULL, '2024-05-23 10:20:06');
INSERT INTO `auditlogdatainfluence` VALUES (101, '29c18c509fe04080b5920382e921e70c', '10', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:20:06', NULL, '2024-05-23 10:20:06');
INSERT INTO `auditlogdatainfluence` VALUES (102, '29c18c509fe04080b5920382e921e70c', '10', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:20:06', NULL, '2024-05-23 10:20:06');
INSERT INTO `auditlogdatainfluence` VALUES (103, '29c18c509fe04080b5920382e921e70c', '36', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+OAService', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (104, '29c18c509fe04080b5920382e921e70c', '37', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+OAService', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (105, '29c18c509fe04080b5920382e921e70c', '38', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+OAService+DEV', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (106, '29c18c509fe04080b5920382e921e70c', '39', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+OAService+DEV', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (107, '0d04c17a565b4695a95ce342c7c04e8c', '20', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (108, '0d04c17a565b4695a95ce342c7c04e8c', '20', 'UserRole', 'RoleId', NULL, '36', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (109, '10cb7f4bac3042c287ee1ae19eab7cd4', '21', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (110, '10cb7f4bac3042c287ee1ae19eab7cd4', '21', 'UserRole', 'RoleId', NULL, '37', b'0', 0, NULL, '2024-05-23 10:20:07', NULL, '2024-05-23 10:20:07');
INSERT INTO `auditlogdatainfluence` VALUES (111, '8cc972ddce704dc38d5fc0e50884f838', '11', 'AppNamespace', 'Name', NULL, 'HRService', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (112, '8cc972ddce704dc38d5fc0e50884f838', '11', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (113, '8cc972ddce704dc38d5fc0e50884f838', '11', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (114, '8cc972ddce704dc38d5fc0e50884f838', '11', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (115, '8cc972ddce704dc38d5fc0e50884f838', '40', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+HRService', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (116, '8cc972ddce704dc38d5fc0e50884f838', '41', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+HRService', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (117, '8cc972ddce704dc38d5fc0e50884f838', '42', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+HRService+DEV', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (118, '8cc972ddce704dc38d5fc0e50884f838', '43', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+HRService+DEV', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (119, '0df2a720f56046738bdbeedc901d0e18', '22', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (120, '0df2a720f56046738bdbeedc901d0e18', '22', 'UserRole', 'RoleId', NULL, '40', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (121, '536c0c27460948d189b0d3df53e36f01', '23', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (122, '536c0c27460948d189b0d3df53e36f01', '23', 'UserRole', 'RoleId', NULL, '41', b'0', 0, NULL, '2024-05-23 10:20:28', NULL, '2024-05-23 10:20:28');
INSERT INTO `auditlogdatainfluence` VALUES (123, 'e56e2eeeedfa4508971477bd90257015', '12', 'AppNamespace', 'Name', NULL, 'PLMService', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (124, 'e56e2eeeedfa4508971477bd90257015', '12', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (125, 'e56e2eeeedfa4508971477bd90257015', '12', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (126, 'e56e2eeeedfa4508971477bd90257015', '12', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (127, 'e56e2eeeedfa4508971477bd90257015', '44', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+PLMService', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (128, 'e56e2eeeedfa4508971477bd90257015', '45', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+PLMService', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (129, 'e56e2eeeedfa4508971477bd90257015', '46', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+PLMService+DEV', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (130, 'e56e2eeeedfa4508971477bd90257015', '47', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+PLMService+DEV', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (131, 'b291dc94b5fc485c8be4e7106f989ea6', '24', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (132, 'b291dc94b5fc485c8be4e7106f989ea6', '24', 'UserRole', 'RoleId', NULL, '44', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (133, '450c113142754784a99941e9db46a952', '25', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (134, '450c113142754784a99941e9db46a952', '25', 'UserRole', 'RoleId', NULL, '45', b'0', 0, NULL, '2024-05-23 10:20:53', NULL, '2024-05-23 10:20:53');
INSERT INTO `auditlogdatainfluence` VALUES (135, '0c0044c317a740628cf9faa4604ac952', '13', 'AppNamespace', 'Name', NULL, 'KMSService', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (136, '0c0044c317a740628cf9faa4604ac952', '13', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (137, '0c0044c317a740628cf9faa4604ac952', '13', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (138, '0c0044c317a740628cf9faa4604ac952', '13', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (139, '0c0044c317a740628cf9faa4604ac952', '48', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+KMSService', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (140, '0c0044c317a740628cf9faa4604ac952', '49', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+KMSService', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (141, '0c0044c317a740628cf9faa4604ac952', '50', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+KMSService+DEV', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (142, '0c0044c317a740628cf9faa4604ac952', '51', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+KMSService+DEV', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (143, '1bb5d142bcb24f8289bc07417b1a2d1c', '26', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (144, '1bb5d142bcb24f8289bc07417b1a2d1c', '26', 'UserRole', 'RoleId', NULL, '48', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (145, 'd3a7b0d066354c1eb30e6a26c1f69c65', '27', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (146, 'd3a7b0d066354c1eb30e6a26c1f69c65', '27', 'UserRole', 'RoleId', NULL, '49', b'0', 0, NULL, '2024-05-23 10:21:47', NULL, '2024-05-23 10:21:47');
INSERT INTO `auditlogdatainfluence` VALUES (147, '03cd93e3bb4d48638ab62ba7ddcf8daa', '14', 'AppNamespace', 'Name', NULL, 'CRMService', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (148, '03cd93e3bb4d48638ab62ba7ddcf8daa', '14', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (149, '03cd93e3bb4d48638ab62ba7ddcf8daa', '14', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (150, '03cd93e3bb4d48638ab62ba7ddcf8daa', '14', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (151, '03cd93e3bb4d48638ab62ba7ddcf8daa', '52', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+CRMService', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (152, '03cd93e3bb4d48638ab62ba7ddcf8daa', '53', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+CRMService', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (153, '03cd93e3bb4d48638ab62ba7ddcf8daa', '54', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+CRMService+DEV', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (154, '03cd93e3bb4d48638ab62ba7ddcf8daa', '55', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+CRMService+DEV', b'0', 0, NULL, '2024-05-23 10:22:57', NULL, '2024-05-23 10:22:57');
INSERT INTO `auditlogdatainfluence` VALUES (155, 'd165dc2bebce46fcb017bde127a025d6', '28', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `auditlogdatainfluence` VALUES (156, 'd165dc2bebce46fcb017bde127a025d6', '28', 'UserRole', 'RoleId', NULL, '52', b'0', 0, NULL, '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `auditlogdatainfluence` VALUES (157, '992314248bf8428884d103cab7226884', '29', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `auditlogdatainfluence` VALUES (158, '992314248bf8428884d103cab7226884', '29', 'UserRole', 'RoleId', NULL, '53', b'0', 0, NULL, '2024-05-23 10:22:58', NULL, '2024-05-23 10:22:58');
INSERT INTO `auditlogdatainfluence` VALUES (159, 'a1082d8c289e464d93865c56c9d4f940', '15', 'AppNamespace', 'Name', NULL, 'SCMService', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (160, 'a1082d8c289e464d93865c56c9d4f940', '15', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (161, 'a1082d8c289e464d93865c56c9d4f940', '15', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (162, 'a1082d8c289e464d93865c56c9d4f940', '15', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (163, 'a1082d8c289e464d93865c56c9d4f940', '56', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+SCMService', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (164, 'a1082d8c289e464d93865c56c9d4f940', '57', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+SCMService', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (165, 'a1082d8c289e464d93865c56c9d4f940', '58', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+SCMService+DEV', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (166, 'a1082d8c289e464d93865c56c9d4f940', '59', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+SCMService+DEV', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (167, 'effbcede88a64489801ec79f43ba8556', '30', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (168, 'effbcede88a64489801ec79f43ba8556', '30', 'UserRole', 'RoleId', NULL, '56', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (169, 'd864d25888ff46dd9cda9d61958d81eb', '31', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (170, 'd864d25888ff46dd9cda9d61958d81eb', '31', 'UserRole', 'RoleId', NULL, '57', b'0', 0, NULL, '2024-05-23 10:24:28', NULL, '2024-05-23 10:24:28');
INSERT INTO `auditlogdatainfluence` VALUES (171, 'd5a66b161e0c48d68ff82c3942f9c87d', '16', 'AppNamespace', 'Name', NULL, 'ISMSService', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (172, 'd5a66b161e0c48d68ff82c3942f9c87d', '16', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (173, 'd5a66b161e0c48d68ff82c3942f9c87d', '16', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (174, 'd5a66b161e0c48d68ff82c3942f9c87d', '16', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (175, 'd5a66b161e0c48d68ff82c3942f9c87d', '60', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+ISMSService', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (176, 'd5a66b161e0c48d68ff82c3942f9c87d', '61', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+ISMSService', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (177, 'd5a66b161e0c48d68ff82c3942f9c87d', '62', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+ISMSService+DEV', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (178, 'd5a66b161e0c48d68ff82c3942f9c87d', '63', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+ISMSService+DEV', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (179, 'b1ec692994024a43890e0f84c1952a07', '32', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (180, 'b1ec692994024a43890e0f84c1952a07', '32', 'UserRole', 'RoleId', NULL, '60', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (181, '03e03491110747cc8622d9387262936a', '33', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (182, '03e03491110747cc8622d9387262936a', '33', 'UserRole', 'RoleId', NULL, '61', b'0', 0, NULL, '2024-05-23 10:25:12', NULL, '2024-05-23 10:25:12');
INSERT INTO `auditlogdatainfluence` VALUES (183, '9edbc45f40f84daa9366680f9e9e53d4', '17', 'AppNamespace', 'Name', NULL, 'BIService', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (184, '9edbc45f40f84daa9366680f9e9e53d4', '17', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (185, '9edbc45f40f84daa9366680f9e9e53d4', '17', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (186, '9edbc45f40f84daa9366680f9e9e53d4', '17', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (187, '9edbc45f40f84daa9366680f9e9e53d4', '64', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+BIService', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (188, '9edbc45f40f84daa9366680f9e9e53d4', '65', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+BIService', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (189, '9edbc45f40f84daa9366680f9e9e53d4', '66', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+BIService+DEV', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (190, '9edbc45f40f84daa9366680f9e9e53d4', '67', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+BIService+DEV', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (191, '976f943ac6e6458687c149eec79133a5', '34', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (192, '976f943ac6e6458687c149eec79133a5', '34', 'UserRole', 'RoleId', NULL, '64', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (193, '54fc46321fd94dc0b1dcc803b0c22fcf', '35', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (194, '54fc46321fd94dc0b1dcc803b0c22fcf', '35', 'UserRole', 'RoleId', NULL, '65', b'0', 0, NULL, '2024-05-23 10:25:34', NULL, '2024-05-23 10:25:34');
INSERT INTO `auditlogdatainfluence` VALUES (195, 'ef7f67eff753472ab9742af51a57e357', '18', 'AppNamespace', 'Name', NULL, 'AIService', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (196, 'ef7f67eff753472ab9742af51a57e357', '18', 'AppNamespace', 'AppId', NULL, 'EIS', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (197, 'ef7f67eff753472ab9742af51a57e357', '18', 'AppNamespace', 'Format', NULL, 'properties', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (198, 'ef7f67eff753472ab9742af51a57e357', '18', 'AppNamespace', 'IsPublic', NULL, 'false', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (199, 'ef7f67eff753472ab9742af51a57e357', '68', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+AIService', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (200, 'ef7f67eff753472ab9742af51a57e357', '69', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+AIService', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (201, 'ef7f67eff753472ab9742af51a57e357', '70', 'Role', 'RoleName', NULL, 'ModifyNamespace+EIS+AIService+DEV', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (202, 'ef7f67eff753472ab9742af51a57e357', '71', 'Role', 'RoleName', NULL, 'ReleaseNamespace+EIS+AIService+DEV', b'0', 0, NULL, '2024-05-23 10:26:25', NULL, '2024-05-23 10:26:25');
INSERT INTO `auditlogdatainfluence` VALUES (203, '42d1e8721c5b44889fe0ac98dc6de862', '36', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');
INSERT INTO `auditlogdatainfluence` VALUES (204, '42d1e8721c5b44889fe0ac98dc6de862', '36', 'UserRole', 'RoleId', NULL, '68', b'0', 0, NULL, '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');
INSERT INTO `auditlogdatainfluence` VALUES (205, '2307d398509f44a483fe6ecdb8c5e1d9', '37', 'UserRole', 'UserId', NULL, 'apollo', b'0', 0, NULL, '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');
INSERT INTO `auditlogdatainfluence` VALUES (206, '2307d398509f44a483fe6ecdb8c5e1d9', '37', 'UserRole', 'RoleId', NULL, '69', b'0', 0, NULL, '2024-05-23 10:26:26', NULL, '2024-05-23 10:26:26');

-- ----------------------------
-- Table structure for authorities
-- ----------------------------
DROP TABLE IF EXISTS `authorities`;
CREATE TABLE `authorities`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Authority` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of authorities
-- ----------------------------
INSERT INTO `authorities` VALUES (1, 'apollo', 'ROLE_user');

-- ----------------------------
-- Table structure for consumer
-- ----------------------------
DROP TABLE IF EXISTS `consumer`;
CREATE TABLE `consumer`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
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
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '开放API消费者' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of consumer
-- ----------------------------

-- ----------------------------
-- Table structure for consumeraudit
-- ----------------------------
DROP TABLE IF EXISTS `consumeraudit`;
CREATE TABLE `consumeraudit`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int UNSIGNED NULL DEFAULT NULL COMMENT 'Consumer Id',
  `Uri` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '访问的Uri',
  `Method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '访问的Method',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_ConsumerId`(`ConsumerId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'consumer审计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of consumeraudit
-- ----------------------------

-- ----------------------------
-- Table structure for consumerrole
-- ----------------------------
DROP TABLE IF EXISTS `consumerrole`;
CREATE TABLE `consumerrole`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int UNSIGNED NULL DEFAULT NULL COMMENT 'Consumer Id',
  `RoleId` int UNSIGNED NULL DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_ConsumerId_RoleId_DeletedAt`(`ConsumerId` ASC, `RoleId` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_RoleId`(`RoleId` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'consumer和role的绑定表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of consumerrole
-- ----------------------------

-- ----------------------------
-- Table structure for consumertoken
-- ----------------------------
DROP TABLE IF EXISTS `consumertoken`;
CREATE TABLE `consumertoken`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int UNSIGNED NULL DEFAULT NULL COMMENT 'ConsumerId',
  `Token` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'token',
  `Expires` datetime NOT NULL DEFAULT '2099-01-01 00:00:00' COMMENT 'token失效时间',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_Token_DeletedAt`(`Token` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'consumer token表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of consumertoken
-- ----------------------------

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '收藏的用户',
  `AppId` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Position` int NOT NULL DEFAULT 10000 COMMENT '收藏顺序',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_UserId_AppId_DeletedAt`(`UserId` ASC, `AppId` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `AppId`(`AppId` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '应用收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of favorite
-- ----------------------------

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `PermissionType` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '权限类型',
  `TargetId` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '权限对象类型',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_TargetId_PermissionType_DeletedAt`(`TargetId` ASC, `PermissionType` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'permission表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'CreateCluster', 'EIS', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:03:36');
INSERT INTO `permission` VALUES (2, 'CreateNamespace', 'EIS', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:03:37');
INSERT INTO `permission` VALUES (3, 'AssignRole', 'EIS', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:03:38');
INSERT INTO `permission` VALUES (4, 'ModifyNamespace', 'EIS+application', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:03:45');
INSERT INTO `permission` VALUES (5, 'ReleaseNamespace', 'EIS+application', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:03:52');
INSERT INTO `permission` VALUES (6, 'ModifyNamespace', 'EIS+GateWayService', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `permission` VALUES (7, 'ReleaseNamespace', 'EIS+GateWayService', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `permission` VALUES (8, 'ModifyNamespace', 'EIS+GateWayService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `permission` VALUES (9, 'ReleaseNamespace', 'EIS+GateWayService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `permission` VALUES (10, 'ModifyNamespace', 'EIS+AuthService', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `permission` VALUES (11, 'ReleaseNamespace', 'EIS+AuthService', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `permission` VALUES (12, 'ModifyNamespace', 'EIS+AuthService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `permission` VALUES (13, 'ReleaseNamespace', 'EIS+AuthService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `permission` VALUES (14, 'ModifyNamespace', 'EIS+AdminService', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `permission` VALUES (15, 'ReleaseNamespace', 'EIS+AdminService', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `permission` VALUES (16, 'ModifyNamespace', 'EIS+AdminService+DEV', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `permission` VALUES (17, 'ReleaseNamespace', 'EIS+AdminService+DEV', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `permission` VALUES (18, 'ModifyNamespace', 'EIS+BaseService', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `permission` VALUES (19, 'ReleaseNamespace', 'EIS+BaseService', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `permission` VALUES (20, 'ModifyNamespace', 'EIS+BaseService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `permission` VALUES (21, 'ReleaseNamespace', 'EIS+BaseService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `permission` VALUES (22, 'ModifyNamespace', 'EIS+BackService', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `permission` VALUES (23, 'ReleaseNamespace', 'EIS+BackService', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `permission` VALUES (24, 'ModifyNamespace', 'EIS+BackService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `permission` VALUES (25, 'ReleaseNamespace', 'EIS+BackService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `permission` VALUES (26, 'ModifyNamespace', 'EIS+CodeService', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `permission` VALUES (27, 'ReleaseNamespace', 'EIS+CodeService', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `permission` VALUES (28, 'ModifyNamespace', 'EIS+CodeService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `permission` VALUES (29, 'ReleaseNamespace', 'EIS+CodeService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `permission` VALUES (30, 'ModifyNamespace', 'EIS+TaskService', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `permission` VALUES (31, 'ReleaseNamespace', 'EIS+TaskService', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `permission` VALUES (32, 'ModifyNamespace', 'EIS+TaskService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `permission` VALUES (33, 'ReleaseNamespace', 'EIS+TaskService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `permission` VALUES (34, 'ModifyNamespace', 'EIS+ERPSerivce', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `permission` VALUES (35, 'ReleaseNamespace', 'EIS+ERPSerivce', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `permission` VALUES (36, 'ModifyNamespace', 'EIS+ERPSerivce+DEV', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `permission` VALUES (37, 'ReleaseNamespace', 'EIS+ERPSerivce+DEV', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `permission` VALUES (38, 'ModifyNamespace', 'EIS+OAService', b'0', 0, 'apollo', '2024-05-23 10:20:06', 'apollo', '2024-05-23 10:20:06');
INSERT INTO `permission` VALUES (39, 'ReleaseNamespace', 'EIS+OAService', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `permission` VALUES (40, 'ModifyNamespace', 'EIS+OAService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `permission` VALUES (41, 'ReleaseNamespace', 'EIS+OAService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `permission` VALUES (42, 'ModifyNamespace', 'EIS+HRService', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `permission` VALUES (43, 'ReleaseNamespace', 'EIS+HRService', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `permission` VALUES (44, 'ModifyNamespace', 'EIS+HRService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `permission` VALUES (45, 'ReleaseNamespace', 'EIS+HRService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `permission` VALUES (46, 'ModifyNamespace', 'EIS+PLMService', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `permission` VALUES (47, 'ReleaseNamespace', 'EIS+PLMService', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `permission` VALUES (48, 'ModifyNamespace', 'EIS+PLMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `permission` VALUES (49, 'ReleaseNamespace', 'EIS+PLMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `permission` VALUES (50, 'ModifyNamespace', 'EIS+KMSService', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `permission` VALUES (51, 'ReleaseNamespace', 'EIS+KMSService', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `permission` VALUES (52, 'ModifyNamespace', 'EIS+KMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `permission` VALUES (53, 'ReleaseNamespace', 'EIS+KMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `permission` VALUES (54, 'ModifyNamespace', 'EIS+CRMService', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `permission` VALUES (55, 'ReleaseNamespace', 'EIS+CRMService', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `permission` VALUES (56, 'ModifyNamespace', 'EIS+CRMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `permission` VALUES (57, 'ReleaseNamespace', 'EIS+CRMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `permission` VALUES (58, 'ModifyNamespace', 'EIS+SCMService', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `permission` VALUES (59, 'ReleaseNamespace', 'EIS+SCMService', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `permission` VALUES (60, 'ModifyNamespace', 'EIS+SCMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `permission` VALUES (61, 'ReleaseNamespace', 'EIS+SCMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `permission` VALUES (62, 'ModifyNamespace', 'EIS+ISMSService', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `permission` VALUES (63, 'ReleaseNamespace', 'EIS+ISMSService', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `permission` VALUES (64, 'ModifyNamespace', 'EIS+ISMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `permission` VALUES (65, 'ReleaseNamespace', 'EIS+ISMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `permission` VALUES (66, 'ModifyNamespace', 'EIS+BIService', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `permission` VALUES (67, 'ReleaseNamespace', 'EIS+BIService', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `permission` VALUES (68, 'ModifyNamespace', 'EIS+BIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `permission` VALUES (69, 'ReleaseNamespace', 'EIS+BIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `permission` VALUES (70, 'ModifyNamespace', 'EIS+AIService', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `permission` VALUES (71, 'ReleaseNamespace', 'EIS+AIService', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `permission` VALUES (72, 'ModifyNamespace', 'EIS+AIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `permission` VALUES (73, 'ReleaseNamespace', 'EIS+AIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `permission` VALUES (74, 'CreateApplication', 'SystemRole', b'0', 0, 'apollo', '2024-05-28 12:59:53', 'apollo', '2024-05-28 12:59:53');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleName` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT 'Role name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_RoleName_DeletedAt`(`RoleName` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'Master+EIS', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:04:02');
INSERT INTO `role` VALUES (2, 'ModifyNamespace+EIS+application', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:04:05');
INSERT INTO `role` VALUES (3, 'ReleaseNamespace+EIS+application', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:04:08');
INSERT INTO `role` VALUES (4, 'ModifyNamespace+EIS+GateWayService', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `role` VALUES (5, 'ReleaseNamespace+EIS+GateWayService', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `role` VALUES (6, 'ModifyNamespace+EIS+GateWayService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `role` VALUES (7, 'ReleaseNamespace+EIS+GateWayService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `role` VALUES (8, 'ModifyNamespace+EIS+AuthService', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `role` VALUES (9, 'ReleaseNamespace+EIS+AuthService', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `role` VALUES (10, 'ModifyNamespace+EIS+AuthService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `role` VALUES (11, 'ReleaseNamespace+EIS+AuthService+DEV', b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `role` VALUES (12, 'ModifyNamespace+EIS+AdminService', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `role` VALUES (13, 'ReleaseNamespace+EIS+AdminService', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `role` VALUES (14, 'ModifyNamespace+EIS+AdminService+DEV', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `role` VALUES (15, 'ReleaseNamespace+EIS+AdminService+DEV', b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `role` VALUES (16, 'ModifyNamespace+EIS+BaseService', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `role` VALUES (17, 'ReleaseNamespace+EIS+BaseService', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `role` VALUES (18, 'ModifyNamespace+EIS+BaseService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `role` VALUES (19, 'ReleaseNamespace+EIS+BaseService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `role` VALUES (20, 'ModifyNamespace+EIS+BackService', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `role` VALUES (21, 'ReleaseNamespace+EIS+BackService', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `role` VALUES (22, 'ModifyNamespace+EIS+BackService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `role` VALUES (23, 'ReleaseNamespace+EIS+BackService+DEV', b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `role` VALUES (24, 'ModifyNamespace+EIS+CodeService', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `role` VALUES (25, 'ReleaseNamespace+EIS+CodeService', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `role` VALUES (26, 'ModifyNamespace+EIS+CodeService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `role` VALUES (27, 'ReleaseNamespace+EIS+CodeService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `role` VALUES (28, 'ModifyNamespace+EIS+TaskService', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `role` VALUES (29, 'ReleaseNamespace+EIS+TaskService', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `role` VALUES (30, 'ModifyNamespace+EIS+TaskService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `role` VALUES (31, 'ReleaseNamespace+EIS+TaskService+DEV', b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `role` VALUES (32, 'ModifyNamespace+EIS+ERPSerivce', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `role` VALUES (33, 'ReleaseNamespace+EIS+ERPSerivce', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `role` VALUES (34, 'ModifyNamespace+EIS+ERPSerivce+DEV', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `role` VALUES (35, 'ReleaseNamespace+EIS+ERPSerivce+DEV', b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `role` VALUES (36, 'ModifyNamespace+EIS+OAService', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `role` VALUES (37, 'ReleaseNamespace+EIS+OAService', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `role` VALUES (38, 'ModifyNamespace+EIS+OAService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `role` VALUES (39, 'ReleaseNamespace+EIS+OAService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `role` VALUES (40, 'ModifyNamespace+EIS+HRService', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `role` VALUES (41, 'ReleaseNamespace+EIS+HRService', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `role` VALUES (42, 'ModifyNamespace+EIS+HRService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `role` VALUES (43, 'ReleaseNamespace+EIS+HRService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `role` VALUES (44, 'ModifyNamespace+EIS+PLMService', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `role` VALUES (45, 'ReleaseNamespace+EIS+PLMService', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `role` VALUES (46, 'ModifyNamespace+EIS+PLMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `role` VALUES (47, 'ReleaseNamespace+EIS+PLMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `role` VALUES (48, 'ModifyNamespace+EIS+KMSService', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `role` VALUES (49, 'ReleaseNamespace+EIS+KMSService', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `role` VALUES (50, 'ModifyNamespace+EIS+KMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `role` VALUES (51, 'ReleaseNamespace+EIS+KMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `role` VALUES (52, 'ModifyNamespace+EIS+CRMService', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `role` VALUES (53, 'ReleaseNamespace+EIS+CRMService', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `role` VALUES (54, 'ModifyNamespace+EIS+CRMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `role` VALUES (55, 'ReleaseNamespace+EIS+CRMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `role` VALUES (56, 'ModifyNamespace+EIS+SCMService', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `role` VALUES (57, 'ReleaseNamespace+EIS+SCMService', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `role` VALUES (58, 'ModifyNamespace+EIS+SCMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `role` VALUES (59, 'ReleaseNamespace+EIS+SCMService+DEV', b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `role` VALUES (60, 'ModifyNamespace+EIS+ISMSService', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `role` VALUES (61, 'ReleaseNamespace+EIS+ISMSService', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `role` VALUES (62, 'ModifyNamespace+EIS+ISMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `role` VALUES (63, 'ReleaseNamespace+EIS+ISMSService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `role` VALUES (64, 'ModifyNamespace+EIS+BIService', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `role` VALUES (65, 'ReleaseNamespace+EIS+BIService', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `role` VALUES (66, 'ModifyNamespace+EIS+BIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `role` VALUES (67, 'ReleaseNamespace+EIS+BIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `role` VALUES (68, 'ModifyNamespace+EIS+AIService', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `role` VALUES (69, 'ReleaseNamespace+EIS+AIService', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `role` VALUES (70, 'ModifyNamespace+EIS+AIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `role` VALUES (71, 'ReleaseNamespace+EIS+AIService+DEV', b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `role` VALUES (72, 'CreateApplication+SystemRole', b'0', 0, 'apollo', '2024-05-28 12:59:53', 'apollo', '2024-05-28 12:59:53');

-- ----------------------------
-- Table structure for rolepermission
-- ----------------------------
DROP TABLE IF EXISTS `rolepermission`;
CREATE TABLE `rolepermission`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleId` int UNSIGNED NULL DEFAULT NULL COMMENT 'Role Id',
  `PermissionId` int UNSIGNED NULL DEFAULT NULL COMMENT 'Permission Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_RoleId_PermissionId_DeletedAt`(`RoleId` ASC, `PermissionId` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_PermissionId`(`PermissionId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 75 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和权限的绑定表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of rolepermission
-- ----------------------------
INSERT INTO `rolepermission` VALUES (1, 1, 1, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `rolepermission` VALUES (2, 1, 2, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `rolepermission` VALUES (3, 1, 3, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `rolepermission` VALUES (4, 2, 4, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `rolepermission` VALUES (5, 3, 5, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `rolepermission` VALUES (6, 4, 6, b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `rolepermission` VALUES (7, 5, 7, b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `rolepermission` VALUES (8, 6, 8, b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `rolepermission` VALUES (9, 7, 9, b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `rolepermission` VALUES (10, 8, 10, b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `rolepermission` VALUES (11, 9, 11, b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `rolepermission` VALUES (12, 10, 12, b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `rolepermission` VALUES (13, 11, 13, b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `rolepermission` VALUES (14, 12, 14, b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `rolepermission` VALUES (15, 13, 15, b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `rolepermission` VALUES (16, 14, 16, b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `rolepermission` VALUES (17, 15, 17, b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `rolepermission` VALUES (18, 16, 18, b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `rolepermission` VALUES (19, 17, 19, b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `rolepermission` VALUES (20, 18, 20, b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `rolepermission` VALUES (21, 19, 21, b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `rolepermission` VALUES (22, 20, 22, b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `rolepermission` VALUES (23, 21, 23, b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `rolepermission` VALUES (24, 22, 24, b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `rolepermission` VALUES (25, 23, 25, b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `rolepermission` VALUES (26, 24, 26, b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `rolepermission` VALUES (27, 25, 27, b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `rolepermission` VALUES (28, 26, 28, b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `rolepermission` VALUES (29, 27, 29, b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `rolepermission` VALUES (30, 28, 30, b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `rolepermission` VALUES (31, 29, 31, b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `rolepermission` VALUES (32, 30, 32, b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `rolepermission` VALUES (33, 31, 33, b'0', 0, 'apollo', '2024-05-23 10:16:42', 'apollo', '2024-05-23 10:16:42');
INSERT INTO `rolepermission` VALUES (34, 32, 34, b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `rolepermission` VALUES (35, 33, 35, b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `rolepermission` VALUES (36, 34, 36, b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `rolepermission` VALUES (37, 35, 37, b'0', 0, 'apollo', '2024-05-23 10:19:18', 'apollo', '2024-05-23 10:19:18');
INSERT INTO `rolepermission` VALUES (38, 36, 38, b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `rolepermission` VALUES (39, 37, 39, b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `rolepermission` VALUES (40, 38, 40, b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `rolepermission` VALUES (41, 39, 41, b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `rolepermission` VALUES (42, 40, 42, b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `rolepermission` VALUES (43, 41, 43, b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `rolepermission` VALUES (44, 42, 44, b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `rolepermission` VALUES (45, 43, 45, b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `rolepermission` VALUES (46, 44, 46, b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `rolepermission` VALUES (47, 45, 47, b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `rolepermission` VALUES (48, 46, 48, b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `rolepermission` VALUES (49, 47, 49, b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `rolepermission` VALUES (50, 48, 50, b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `rolepermission` VALUES (51, 49, 51, b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `rolepermission` VALUES (52, 50, 52, b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `rolepermission` VALUES (53, 51, 53, b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `rolepermission` VALUES (54, 52, 54, b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `rolepermission` VALUES (55, 53, 55, b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `rolepermission` VALUES (56, 54, 56, b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `rolepermission` VALUES (57, 55, 57, b'0', 0, 'apollo', '2024-05-23 10:22:57', 'apollo', '2024-05-23 10:22:57');
INSERT INTO `rolepermission` VALUES (58, 56, 58, b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `rolepermission` VALUES (59, 57, 59, b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `rolepermission` VALUES (60, 58, 60, b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `rolepermission` VALUES (61, 59, 61, b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `rolepermission` VALUES (62, 60, 62, b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `rolepermission` VALUES (63, 61, 63, b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `rolepermission` VALUES (64, 62, 64, b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `rolepermission` VALUES (65, 63, 65, b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `rolepermission` VALUES (66, 64, 66, b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `rolepermission` VALUES (67, 65, 67, b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `rolepermission` VALUES (68, 66, 68, b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `rolepermission` VALUES (69, 67, 69, b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `rolepermission` VALUES (70, 68, 70, b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `rolepermission` VALUES (71, 69, 71, b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `rolepermission` VALUES (72, 70, 72, b'0', 0, 'apollo', '2024-05-23 10:26:25', 'apollo', '2024-05-23 10:26:25');
INSERT INTO `rolepermission` VALUES (73, 71, 73, b'0', 0, 'apollo', '2024-05-23 10:26:26', 'apollo', '2024-05-23 10:26:26');
INSERT INTO `rolepermission` VALUES (74, 72, 74, b'0', 0, 'apollo', '2024-05-28 12:59:53', 'apollo', '2024-05-28 12:59:53');

-- ----------------------------
-- Table structure for serverconfig
-- ----------------------------
DROP TABLE IF EXISTS `serverconfig`;
CREATE TABLE `serverconfig`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Value` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '配置项值',
  `Comment` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_Key_DeletedAt`(`Key` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '配置服务自身配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of serverconfig
-- ----------------------------
INSERT INTO `serverconfig` VALUES (1, 'apollo.portal.envs', 'dev', '可支持的环境列表', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `serverconfig` VALUES (2, 'organizations', '[{\"orgId\":\"IT\",\"orgName\":\"软件开发部\"},{\"orgId\":\"EIS\",\"orgName\":\"企业信息一体化平台部\"}]', '部门列表', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 02:05:20');
INSERT INTO `serverconfig` VALUES (3, 'superAdmin', 'apollo', 'Portal超级管理员', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `serverconfig` VALUES (4, 'api.readTimeout', '10000', 'http接口read timeout', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `serverconfig` VALUES (5, 'consumer.token.salt', 'someSalt', 'consumer token salt', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `serverconfig` VALUES (6, 'admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `serverconfig` VALUES (7, 'configView.memberOnly.envs', 'dev', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `serverconfig` VALUES (8, 'apollo.portal.meta.servers', '{}', '各环境Meta Service列表', b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');

-- ----------------------------
-- Table structure for spring_session
-- ----------------------------
DROP TABLE IF EXISTS `spring_session`;
CREATE TABLE `spring_session`  (
  `PRIMARY_ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `SESSION_ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`) USING BTREE,
  UNIQUE INDEX `SPRING_SESSION_IX1`(`SESSION_ID` ASC) USING BTREE,
  INDEX `SPRING_SESSION_IX2`(`EXPIRY_TIME` ASC) USING BTREE,
  INDEX `SPRING_SESSION_IX3`(`PRINCIPAL_NAME` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of spring_session
-- ----------------------------
INSERT INTO `spring_session` VALUES ('5d9f2fce-9210-4b6b-8450-43465ded98b3', '11d7166b-592b-4985-9af0-1257ff0104bc', 1716941644478, 1716942557180, 1800, 1716944357180, 'apollo');

-- ----------------------------
-- Table structure for spring_session_attributes
-- ----------------------------
DROP TABLE IF EXISTS `spring_session_attributes`;
CREATE TABLE `spring_session_attributes`  (
  `SESSION_PRIMARY_ID` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`, `ATTRIBUTE_NAME`) USING BTREE,
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of spring_session_attributes
-- ----------------------------
INSERT INTO `spring_session_attributes` VALUES ('5d9f2fce-9210-4b6b-8450-43465ded98b3', 'SPRING_SECURITY_CONTEXT', 0x7B2240636C617373223A226F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E636F6E746578742E5365637572697479436F6E74657874496D706C222C2261757468656E7469636174696F6E223A7B2240636C617373223A226F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E222C22617574686F726974696573223A5B226A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C6552616E646F6D4163636573734C697374222C5B7B2240636C617373223A226F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479222C22617574686F72697479223A22524F4C455F75736572227D5D5D2C2264657461696C73223A7B2240636C617373223A226F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C73222C2272656D6F746541646472657373223A223137322E31382E302E31222C2273657373696F6E4964223A2238653261353162652D376339312D343231622D613730342D633034313436633238343066227D2C2261757468656E74696361746564223A747275652C227072696E636970616C223A7B2240636C617373223A226F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E55736572222C2270617373776F7264223A6E756C6C2C22757365726E616D65223A2261706F6C6C6F222C22617574686F726974696573223A5B226A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574222C5B7B2240636C617373223A226F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F72697479222C22617574686F72697479223A22524F4C455F75736572227D5D5D2C226163636F756E744E6F6E45787069726564223A747275652C226163636F756E744E6F6E4C6F636B6564223A747275652C2263726564656E7469616C734E6F6E45787069726564223A747275652C22656E61626C6564223A747275657D2C2263726564656E7469616C73223A6E756C6C7D7D);

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `UserId` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户身份标识',
  `RoleId` int UNSIGNED NULL DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DeletedAt` bigint NOT NULL DEFAULT 0 COMMENT 'Delete timestamp based on milliseconds',
  `DataChange_CreatedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_UserId_RoleId_DeletedAt`(`UserId` ASC, `RoleId` ASC, `DeletedAt` ASC) USING BTREE,
  INDEX `IX_DataChange_LastTime`(`DataChange_LastTime` ASC) USING BTREE,
  INDEX `IX_RoleId`(`RoleId` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和role的绑定表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of userrole
-- ----------------------------
INSERT INTO `userrole` VALUES (1, 'apollo', 1, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `userrole` VALUES (2, 'apollo', 2, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `userrole` VALUES (3, 'apollo', 3, b'0', 0, 'default', '2024-05-23 01:05:36', '', '2024-05-23 01:05:36');
INSERT INTO `userrole` VALUES (4, 'apollo', 4, b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `userrole` VALUES (5, 'apollo', 5, b'0', 0, 'apollo', '2024-05-23 10:08:29', 'apollo', '2024-05-23 10:08:29');
INSERT INTO `userrole` VALUES (6, 'apollo', 8, b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `userrole` VALUES (7, 'apollo', 9, b'0', 0, 'apollo', '2024-05-23 10:08:54', 'apollo', '2024-05-23 10:08:54');
INSERT INTO `userrole` VALUES (8, 'apollo', 12, b'0', 0, 'apollo', '2024-05-23 10:09:45', 'apollo', '2024-05-23 10:09:45');
INSERT INTO `userrole` VALUES (9, 'apollo', 13, b'0', 0, 'apollo', '2024-05-23 10:09:46', 'apollo', '2024-05-23 10:09:46');
INSERT INTO `userrole` VALUES (10, 'apollo', 16, b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `userrole` VALUES (11, 'apollo', 17, b'0', 0, 'apollo', '2024-05-23 10:10:13', 'apollo', '2024-05-23 10:10:13');
INSERT INTO `userrole` VALUES (12, 'apollo', 20, b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `userrole` VALUES (13, 'apollo', 21, b'0', 0, 'apollo', '2024-05-23 10:10:34', 'apollo', '2024-05-23 10:10:34');
INSERT INTO `userrole` VALUES (14, 'apollo', 24, b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `userrole` VALUES (15, 'apollo', 25, b'0', 0, 'apollo', '2024-05-23 10:16:20', 'apollo', '2024-05-23 10:16:20');
INSERT INTO `userrole` VALUES (16, 'apollo', 28, b'0', 0, 'apollo', '2024-05-23 10:16:43', 'apollo', '2024-05-23 10:16:43');
INSERT INTO `userrole` VALUES (17, 'apollo', 29, b'0', 0, 'apollo', '2024-05-23 10:16:43', 'apollo', '2024-05-23 10:16:43');
INSERT INTO `userrole` VALUES (18, 'apollo', 32, b'0', 0, 'apollo', '2024-05-23 10:19:19', 'apollo', '2024-05-23 10:19:19');
INSERT INTO `userrole` VALUES (19, 'apollo', 33, b'0', 0, 'apollo', '2024-05-23 10:19:19', 'apollo', '2024-05-23 10:19:19');
INSERT INTO `userrole` VALUES (20, 'apollo', 36, b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `userrole` VALUES (21, 'apollo', 37, b'0', 0, 'apollo', '2024-05-23 10:20:07', 'apollo', '2024-05-23 10:20:07');
INSERT INTO `userrole` VALUES (22, 'apollo', 40, b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `userrole` VALUES (23, 'apollo', 41, b'0', 0, 'apollo', '2024-05-23 10:20:28', 'apollo', '2024-05-23 10:20:28');
INSERT INTO `userrole` VALUES (24, 'apollo', 44, b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `userrole` VALUES (25, 'apollo', 45, b'0', 0, 'apollo', '2024-05-23 10:20:53', 'apollo', '2024-05-23 10:20:53');
INSERT INTO `userrole` VALUES (26, 'apollo', 48, b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `userrole` VALUES (27, 'apollo', 49, b'0', 0, 'apollo', '2024-05-23 10:21:47', 'apollo', '2024-05-23 10:21:47');
INSERT INTO `userrole` VALUES (28, 'apollo', 52, b'0', 0, 'apollo', '2024-05-23 10:22:58', 'apollo', '2024-05-23 10:22:58');
INSERT INTO `userrole` VALUES (29, 'apollo', 53, b'0', 0, 'apollo', '2024-05-23 10:22:58', 'apollo', '2024-05-23 10:22:58');
INSERT INTO `userrole` VALUES (30, 'apollo', 56, b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `userrole` VALUES (31, 'apollo', 57, b'0', 0, 'apollo', '2024-05-23 10:24:28', 'apollo', '2024-05-23 10:24:28');
INSERT INTO `userrole` VALUES (32, 'apollo', 60, b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `userrole` VALUES (33, 'apollo', 61, b'0', 0, 'apollo', '2024-05-23 10:25:12', 'apollo', '2024-05-23 10:25:12');
INSERT INTO `userrole` VALUES (34, 'apollo', 64, b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `userrole` VALUES (35, 'apollo', 65, b'0', 0, 'apollo', '2024-05-23 10:25:34', 'apollo', '2024-05-23 10:25:34');
INSERT INTO `userrole` VALUES (36, 'apollo', 68, b'0', 0, 'apollo', '2024-05-23 10:26:26', 'apollo', '2024-05-23 10:26:26');
INSERT INTO `userrole` VALUES (37, 'apollo', 69, b'0', 0, 'apollo', '2024-05-23 10:26:26', 'apollo', '2024-05-23 10:26:26');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '用户登录账户',
  `Password` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '密码',
  `UserDisplayName` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '用户名称',
  `Email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  `Enabled` tinyint NULL DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`Id`) USING BTREE,
  UNIQUE INDEX `UK_Username`(`Username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo', 'apollo@acme.com', 1);

SET FOREIGN_KEY_CHECKS = 1;
