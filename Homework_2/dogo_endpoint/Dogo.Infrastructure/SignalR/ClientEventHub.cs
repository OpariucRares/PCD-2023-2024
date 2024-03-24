using Dogo.Infrastructure.SignalR;
using Microsoft.AspNetCore.SignalR;

namespace Tempus.Infrastructure.SignalR;

public class ClientEventHub : Hub
{
	private readonly IConnectionManager _connections;

	public ClientEventHub()
	{
		_connections = new ConnectionManager();
	}

	public override Task OnConnectedAsync()
	{
		var userId = Context.User.Claims.FirstOrDefault(x => x.Type.Contains("nameidentifier"))?.Value;

		_connections.RegisterConnection(userId, Context.ConnectionId);
		return base.OnConnectedAsync();
	}

	public override Task OnDisconnectedAsync(
		Exception exception
	)
	{
		var name = Context.User.Claims.FirstOrDefault(x => x.Type.Contains("nameidentifier"))?.Value;

		_connections.RemoveConnection(name, Context.ConnectionId);

		return base.OnDisconnectedAsync(exception);
	}

	public async Task UpdatePosition(
		string position
	)
	{

		await Clients.All.SendAsync("ReceivedPosition", position);
	}
}

