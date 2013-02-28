Name:		crontab-randomizer
Version:	1
Release:	2.selectel
BuildArch:  noarch
Summary:    Randomizes default crontab times
Group:		System Environment/Base
License:	GPLv3
BuildRoot:  %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Source:     %{name}-%{version}.tar.gz

%description
Rndomizes crontab start times for cron.daily, cron.hourly etc.
%prep
mkdir -p "%{buildroot}"                                                         
%setup
%build
%install
cp -r * "$RPM_BUILD_ROOT"/
%clean
rm -rf %{buildroot}
%pre
%post
echo "Running crontab randomization"
/usr/bin/crontab-randomizer
service crond reload
%preun
%postun
%files
%defattr(-,root,root,-)
%doc
/usr/bin/crontab-randomizer
%changelog
* Thu Feb 28 2013 Selectel
 - Moved randomization script to /usr/bin
* Thu Jan 20 2013 Selectel
 - Initial package
