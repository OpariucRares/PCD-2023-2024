using Dogo.Infrastructure.SignalR;
using System.Collections.Concurrent;

namespace Tempus.Infrastructure.SignalR;

public class ConnectionManager : IConnectionManager
{
	private static readonly ConcurrentDictionary<string, HashSet<string>> _connections = new();

	public void RegisterConnection(string userId, string connectionId)
	{
		if(string.IsNullOrWhiteSpace(userId))
		{
			userId = "";
		}

		lock(_connections)
		{
			HashSet<string> connections;
			if(!_connections.TryGetValue(userId, out connections))
			{
				connections = new HashSet<string>();
				_connections.TryAdd(userId, connections);
			}

			lock(connections)
			{
				connections.Add(connectionId);
			}
		}

		Console.WriteLine("Registered connection: " + connectionId);
	}

	public void RemoveConnection(string userId, string connectionId)
	{
		if(string.IsNullOrWhiteSpace(userId))
		{
			userId = "";
		}

		lock(_connections)
		{
			HashSet<string> connections;
			if(!_connections.TryGetValue(userId, out connections))
			{
				return;
			}

			lock(connections)
			{
				connections.Remove(connectionId);
				if(connections.Count == 0)
				{
					_connections.Remove(userId, out _);
				}
			}
		}
	}

	public IEnumerable<string> GetConnections(string userId)
	{
		HashSet<string> connections;
		if(_connections.TryGetValue(userId, out connections))
		{
			return connections;
		}

		return Enumerable.Empty<string>();
	}

	public IEnumerable<string> GetConnections()
	{
		return _connections.Values.SelectMany(connections => connections);
	}
}