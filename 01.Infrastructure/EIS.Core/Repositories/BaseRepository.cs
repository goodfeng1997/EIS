using EIS.Core.Base.DataBaseLinq;
using Microsoft.Extensions.Logging;

namespace EIS.Core.Repositories;

/// <summary>
/// 基础仓储
/// </summary>
public class BaseRepository
{
    private ILogger<BaseRepository> _logger;
    private IDbService _dbService;

    /// <summary>
    /// 基础仓储
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="dbService"></param>
    public BaseRepository(ILogger<BaseRepository> logger, IDbService dbService)
    {
        _logger = logger;
        _dbService = dbService;
    }
    
    

}