namespace Dogo.Infrastructure.SignalR;

public interface IConnectionManager
{
	void RegisterConnection(string userId, string connectionId);

	void RemoveConnection(string userId, string connectionId);

	IEnumerable<string> GetConnections(string userId);

	IEnumerable<string> GetConnections();
}