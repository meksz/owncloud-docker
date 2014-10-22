<h1>Description</h1>

<b>Minimalistic configuration to run Wordpress 4.</b>

The following services were installed and conttrolled by supervisord.

<ul>
<li>Supervisord</li>
<li>Sshd</li>
<li>Apache2</li>
<li>Mysql</li>
</ul>

<h3>Create "shared" folder to attach it to the following folders from the container:</h3>

<pre>/var/lib/mysql</pre>
<pre>/wordpress</pre>

<h3>Working with container</h3>

<b>Run container:</b> You can run this once then control with docker stop/start</b>
<pre>./run-wordpress.sh</pre>

<b>Stop container</b>
<pre>docker stop wordpress</pre>

<b>Resume container</b>
<pre>docker start wordpress</pre>

<i>You don't need 'docker run' everytime.</i>

<h3>Mysql Config</h3>
<b>Settings for wordpress db in Mysql (see scripts/start-up.sh)</b>

DB: <pre>wordpress</pre>
Userid/Password: <pre>wordpress / wordpress</pre>

<h3>Debugging: Attach TTY to running container</h3>

You can attach tty to container by nsenter for debugging purposes. Use the following script:
<pre>scripts/dconnect.sh [container id]</pre>

<i>Contact me for the issues: meks.bazz@gmail.com</i>
