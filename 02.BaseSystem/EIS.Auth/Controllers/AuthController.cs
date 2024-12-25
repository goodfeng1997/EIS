using EIS.Model.Dto;
using Microsoft.AspNetCore.Mvc;

namespace EIS.Auth.Controllers;

/// <summary>
/// 权限管理
/// </summary>
[Route("auth")]
[Produces("application/json")]
public class AuthController : ControllerBase
{
    /// <summary>
    /// 构造函数
    /// </summary>
    public AuthController()
    {
        
    }

    /// <summary>
    /// 登录接口
    /// </summary>
    /// <param name="model"></param>
    /// <returns></returns>
    [HttpPost]
    [Route("login")]
    public async Task<ActionResult> Login(LoginRequestParam model)
    {
        //var tenantId = Request.Headers["TenantId"].ToString();
        
        var dict = new Dictionary<string, string>
        {
            ["client_id"] = "",
            ["username"] = model.UserName,
            ["password"] = model.Password,
            ["client_secret"] = "Admin",
            ["grant_type"] = "password"
        };
        var content = new FormUrlEncodedContent(dict);
        const string url = "http://localhost:5001/connect/token";
        using var client = new HttpClient();
        var response = await client.PostAsync(url, content);
        if (response.IsSuccessStatusCode)
        {
            var result = await response.Content.ReadAsStringAsync();
            return Content(result, "application/json");
        }
        else
        {
            return StatusCode(Convert.ToInt32(response.StatusCode));
        }
    }
}