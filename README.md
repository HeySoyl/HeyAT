# HeyAT
[![Version](https://img.shields.io/badge/Version-1.0.0-green.svg)](#)
[![Vapor](https://img.shields.io/badge/Vapor-3.0+-blue.svg)](http://docs.vapor.codes/3.0/)
[![Swift](https://img.shields.io/badge/Swift-4.2.1+-orange.svg)](https://swift.org)

# 接口API

## 用户操作接口

用户相关接口包括登录、注册、获取个人信息、设置个人信息、退出登录。

### 注册

> oauth/regist

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| phone | 是 | string | 账号 |
| password | 是 | string | 密码 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| status | int | 0 = 验证成功；1001：输入手机号；1002: 输入密码 |
| message | string | 描述字段 |
| data | string | 登录成功返回信息 |

##### 返回示例


```
{
  "status": 0,
  "message": "注册成功",
  "data": {
    "token": "ndkjd-YrM6KmiEcWkns0Llz1o6nv8lY9FC6oEzJ7rOY",
    "userID": 5,
    "expiryTime": "2019-04-13T02:38:51Z"
  }
}
```

### 登陆

> oauth/login

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| phone | 是 | string | 账号 |
| password | 是 | string | 密码 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| status | int | 0 = 请求成功 |
| message | string | 描述字段 |
| data | string | 注册成功则返回 Token |

##### 返回示例


```
{
  "status": 0,
  "message": "登陆成功"
}
```

### 获取用户个人信息

> oauth/getUserInfo

##### 请求方式：POST

##### 请求Headers

`Authorization`

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| status | int | 0 = 验证成功 |
| message | string | 描述字段 |
| phone | string | 注册手机号 |

##### 返回示例


```
{
  "status": 0,
  "message": "Token验证成功",
  "data": {
    "id": 3,
    "phone": "1855371441311",
    "password": "12311"
  }
}
```
### 退出登录

> oauth/exit

##### 请求方式：POST

##### 请求Headers

`Authorization`

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| status | int | 0 = 验证成功 |
| message | string | 描述字段 |

##### 返回示例


```
{
  "status": 0,
  "message": "注销成功"
}
```
## 业务线

业务线相关接口包含增、删、改、查

### 创建业务线

> businesses/create

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| name | 否 | string | 名称 |
| desc | 否 | string | 描述 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| status | int | 0 = 成功 |
| message | string | 描述字段|


##### 返回示例


```
{
  "status": 0,
  "message": "保存成功"
}
```
### 获取业务线

> businesses/select

##### 请求方式：POST

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| id | 否 | int | 业务线 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| id | int | id |
| rediskey | string | 缓冲地址 |
| name | string | 名称 |
| desc | string | 描述 |



##### 返回示例


```
{
  "status": 0,
  "message": "查询成功",
  "data": [
    {
      "id": 1,
      "rediskey": "Business rediskey:1",
      "name": "Business name:1",
      "desc": "Business desc:1"
    }
  ]
}
```

### 更新业务线

> businesses/update

##### 请求方式：PATCH

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| desc | 否 | string | 描述 |
| rediskey | 否 | string | 缓冲地址 |
| name | 否 | string | 名称 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| status | int | 0 = 成功 |
| message | string | 描述字段|



##### 返回示例


```
{
  "status": 0,
  "message": "保存成功"
}
```

### 删除业务线

> businesses/delete

##### 请求方式：DELETE

##### 请求参数

|参数|必选|类型|说明|
|:--|:---|:---|:--- |
| id | 否 | int | 业务线 |

##### 返回字段

|返回字段|字段类型|说明 |
|:----- |:------|:---|
| status | int | 0 = 成功 |
| message | string | 描述字段|


##### 返回示例


```
{
  "status": 1022,
  "message": "ID不存在"
}
```

## 用例相关接口

用例相关接口包含增、删、改、查
