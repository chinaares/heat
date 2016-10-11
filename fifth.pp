file { '$::domain':
    ensure  => file,
    mode    => '0644',
    path    => '/etc/httpd/conf.d/$::domain',
    content => '$::content',
    notify  => Service['httpd'],
}

package {
 ensutre => present,
 name => httpd,
}

service {
 ensure => running,
 name => httpd,
 require => Package['httpd'],
 enable => true

}

file { 'output_result':
    ensure  => file,
    path    => '$::heat_outputs_path.result',
    mode    => '0644',
    content => 'The file /tmp/$::domain contains $::content',
}
