package me.xplabs.utils {
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	import me.xplabs.interfaces.net.IServerSocket;
	import me.xplabs.interfaces.servers.IBaseMessage;
	import me.xplabs.net.model.SocketServer;
	import me.xplabs.servers.MessageType;
	import me.xplabs.utils.printMsg;

	/**
	 * 
	 * ...
	 * @author xiaohan
	 */
	public class MessageHandle {
		/**
		 * 消息映射的数据描述
		 */
		private static var _msgDescribe : Dictionary;
		/**
		 * socketServer管理器
		 */
		private static var _socketServer : IServerSocket;

		/**
		 * 设置SocketServer管理器
		 */
		public static function set socketServer(socket : IServerSocket) : void {
			_socketServer = socket;
		}

		/**
		 * 写入消息发哦是那个消息到客户端
		 * @param	clinetId 客户端id
		 * @param	baseMessage 消息数据
		 */
		public static function sendMessage(clinetId : String, baseMessage : IBaseMessage) : void {
			printMsg(baseMessage.type);
			baseMessage.bytes = new ByteArray();
			baseMessage.write();
			_socketServer.send(clinetId, baseMessage);
		}

		/**
		 * 获取消息类型描述的映射
		 * @param	msgType 消息类型
		 * @return 消息类型的描述
		 */
		public static function msgMapping(msgType : int) : String {
			if (_msgDescribe) return _msgDescribe[msgType];
			_msgDescribe = new Dictionary();
			_msgDescribe[MessageType.CS_LOGIN] = "收到登录游戏请求--CS_LOGIN=" + MessageType.CS_LOGIN;
			_msgDescribe[MessageType.SC_LOGIN_RESULT] = "发送登录游戏结果--SC_LOGIN_RESULT=" + MessageType.SC_LOGIN_RESULT;
			return _msgDescribe[msgType];
		}
	}
}