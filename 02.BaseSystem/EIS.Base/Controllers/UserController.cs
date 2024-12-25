using System.Data;
using EIS.Core.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace EIS.Base.Controllers;

/// <summary>
/// 用户管理
/// </summary>
[ApiController]
[Route("base/[controller]")]
[Authorize]
public class UserController : ControllerBase
{
    private readonly ILogger<UserController> _logger;
    private readonly IDbConnection _dbConnection;
    private readonly IAppDbService _appDbService;

    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="dbConnection"></param>
    /// <param name="appDbService"></param>
    /// <param name="logger"></param>
    public UserController(IDbConnection dbConnection, 
        IAppDbService appDbService, 
        ILogger<UserController> logger)
    {
        _logger = logger;
        _dbConnection = dbConnection;
        _appDbService = appDbService;
    }
    
    /// <summary>
    /// 初始化请求
    /// </summary>
    /// <returns></returns>
    [HttpGet("get")]
    public IActionResult Get()
    {
        var authCode = Request.Headers["AuthCode"].ToString();
        return new JsonResult(from c in User.Claims select new { c.Type, c.Value });
    }
}